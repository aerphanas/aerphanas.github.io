FROM haskell:9.2-slim
RUN cabal update && cabal new-install hakyll
ENTRYPOINT ["hakyll-init"]
