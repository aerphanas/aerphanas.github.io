{-# LANGUAGE OverloadedStrings #-}
module Main where

import Hakyll
import Text.Pandoc.Highlighting ( haddock, styleToCss, Style )
import Text.Pandoc.Options ( WriterOptions(writerHighlightStyle) )

root :: String
root = "https://aerphanas.github.io"

pandocCodeStyle :: Style
pandocCodeStyle = haddock

pandocCompiler' :: Compiler (Item String)
pandocCompiler' = pandocCompilerWith
                  defaultHakyllReaderOptions
                  defaultHakyllWriterOptions
                  { writerHighlightStyle = Just pandocCodeStyle }

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "aerphanas blog"
    , feedDescription = "blog untuk berbagi ilmu seputar teknologi dalam bahasa indonesia"
    , feedAuthorName  = "aerphanas"
    , feedAuthorEmail = "muhamadaviv14@gmail.com"
    , feedRoot        = "aerphanas.github.io"
    }

config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs"
                              , inMemoryCache = True
                              }

postCtx :: Context String
postCtx = constField     "root"      root           <>
          dateField      "sitedate"  "%Y-%m-%d"     <>
          dateField      "date"      "%b %d, %Y"    <>
          openGraphField "opengraph" defaultContext <>
          defaultContext

exposeFile :: Pattern -> Rules ()
exposeFile patterns = match patterns $
                      route idRoute >>
                      compile copyFileCompiler

main :: IO ()
main = hakyllWith config $ do
    exposeFile "robots.txt"
    exposeFile "font/*"
    exposeFile "images/*"
    exposeFile "css/*"
    exposeFile "404.html"
    match "templates/*"  $ compile templateBodyCompiler
    match "etc/about.md" $ do
        route   $ setExtension   "html"
        compile $ pandocCompiler                                  >>=
          loadAndApplyTemplate   "templates/default.html" postCtx >>=
          relativizeUrls

    match "posts/*" $ do
        route $ setExtension         "html"
        compile $ do
            let postWithOg =
                    constField       "root"      root       <>
                    openGraphField   "opengraph" postWithOg <>
                    twitterCardField "twitter"   postWithOg <>
                    defaultContext
            pandocCompiler'                                            >>=
              loadAndApplyTemplate "templates/post.html"    postCtx    >>=
              saveSnapshot         "content"                           >>=
              loadAndApplyTemplate "templates/default.html" postWithOg >>=
              relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <-  loadAll "posts/*" >>= fmap (take 5) . recentFirst
            let indexCtx = listField      "posts"     postCtx (return posts) <>
                           constField     "root"      root                   <>
                           openGraphField "opengraph" indexCtx               <>
                           defaultContext
            getResourceBody                                          >>=
              applyAsTemplate indexCtx                               >>=
              loadAndApplyTemplate "templates/default.html" indexCtx >>=
              relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- loadAll "posts/*" >>= recentFirst
            let archiveCtx =
                    listField  "posts"  postCtx (return posts)                                      <>
                    constField "root"   root                                                        <>
                    constField "title" "Arsip"                                                      <>
                    constField "desc"  "Semua postingan yang ada diaerphanas bisa dilihat di sini"  <>
                    defaultContext
            makeItem ""                                                  >>=
              loadAndApplyTemplate "templates/archive-list.html" archiveCtx >>=
              loadAndApplyTemplate "templates/default.html"   archiveCtx >>=
              relativizeUrls


    create ["sitemap.xml"] $ do
        route idRoute
        compile $ do
            posts <- loadAll "posts/*" >>= recentFirst
            singlePages <- loadAll $ fromList ["etc/about.md"]
            let pages = posts <> singlePages
                sitemapCtx = constField "root"  root <> listField  "pages" postCtx (return pages)
            makeItem "" >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx <> constField "description" "aerphanas blog update"
            posts <- loadAllSnapshots "posts/*" "content" >>= fmap (take 10) . recentFirst
            renderAtom myFeedConfiguration feedCtx posts

    create ["css/syntax.css"] $
        route idRoute >> (compile . makeItem . styleToCss) pandocCodeStyle
