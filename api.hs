{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Text.Pandoc.Highlighting (Style, breezeDark, styleToCss)
import Text.Pandoc.Options      (ReaderOptions (..), WriterOptions (..))

pandocCodeStyle :: Style
pandocCodeStyle = breezeDark

pandocCompiler' :: Compiler (Item String)
pandocCompiler' =
  pandocCompilerWith
    defaultHakyllReaderOptions
    defaultHakyllWriterOptions
      { writerHighlightStyle = Just pandocCodeStyle }

root :: String
root = "https://aerphanas.github.io"

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "aerphanas blog"
    , feedDescription = "blog untuk berbagi ilmu seputar teknologi dalam bahasa indonesia"
    , feedAuthorName  = "aerphanas"
    , feedAuthorEmail = "muhamadaviv14@gmail.com"
    , feedRoot        = "aerphanas.github.io"
    }

config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs" }

main :: IO ()
main = hakyllWith config $ do
    match "templates/*" $ compile templateBodyCompiler
    
    match "robots.txt" $ do
        route   idRoute
        compile copyFileCompiler

    match "font/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "etc/about.md" $ do
        route   $ setExtension       "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension         "html"
        compile $ pandocCompiler'
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot         "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <-  (fmap (take 5) . recentFirst) =<< loadAll "posts/*"
            let indexCtx =
                    listField  "posts" postCtx (return posts) <>
                    constField "root"  root                   <>
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField  "posts"  postCtx (return posts)                                      <>
                    constField "root"   root                                                        <>
                    constField "title" "Arsip"                                                      <>
                    constField "desc"  "Semua postingan yang ada diaerphanas bisa dilihat di sini"  <>
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/post-list.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    create ["sitemap.xml"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            singlePages <- loadAll (fromList ["etc/about.md"])
            let pages = posts <> singlePages
                sitemapCtx =
                    constField "root"  root <>
                    listField  "pages" postCtx (return pages)
            makeItem ""
                >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx <>
                    constField "description" "aerphanas blog update"

            posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
            renderAtom myFeedConfiguration feedCtx posts

    create ["css/syntax.css"] $ do
        route idRoute
        compile $ do
            makeItem $ styleToCss pandocCodeStyle

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    constField "root"     root        <>
    dateField  "sitedate" "%Y-%m-%d"  <>
    dateField  "date"     "%b %d, %Y" <>
    defaultContext
