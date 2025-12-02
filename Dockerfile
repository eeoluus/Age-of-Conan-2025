FROM haskell:slim-bullseye
WORKDIR /app
COPY ./src .
RUN ghc -o day0 ./Day0.hs
RUN ghc -o day1a ./Day1a.hs
ENTRYPOINT []
CMD ["./day1a"]