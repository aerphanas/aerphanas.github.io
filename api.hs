--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import  Data.Monoid (mappend)
import  Hakyll
--------------------------------------------------------------------------------

root :: String
root = "https://aerphanas.github.io"

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "aerphanas blog"
    , feedDescription = "blog untuk berbagi ilmu"
    , feedAuthorName  = "aerphanas"
    , feedAuthorEmail = "muhamadaviv14@gmail.com"
    , feedRoot        = "aerphanas.github.io"
    }

config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs" }

main :: IO ()
main = hakyllWith config $ do
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
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <-  (fmap (take 5) . recentFirst) =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "root" root `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
--------------------------------------------------------------------------------
    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "root" root `mappend`
                    constField "title" "Arsip"            `mappend`
                    constField "desc" "Semua postingan yang ada di aerphanas bisa dilihat di sini"  `mappend`
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
                    constField "root" root `mappend`
                    listField "pages" postCtx (return pages)
            makeItem ""
                >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx `mappend`
                    constField "description" "aerphanas blog update"

            posts <- fmap (take 10) . recentFirst =<< loadAllSnapshots "posts/*" "content"
            renderAtom myFeedConfiguration feedCtx posts

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    constField "root"     root        `mappend`
    dateField  "sitedate" "%Y-%m-%d"  `mappend`
    dateField  "date"     "%b %d, %Y" `mappend`
    defaultContext
