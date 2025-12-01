FROM haskell:slim-bullseye
WORKDIR /app
COPY ./src .
RUN ghc -o day0 ./Day0.hs
ENTRYPOINT []
CMD ["./day0"]