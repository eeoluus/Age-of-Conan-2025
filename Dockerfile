FROM haskell:slim-bullseye
WORKDIR /app
COPY ./src .
RUN ghc -o day0 ./Day0.hs
RUN ghc -o day1a ./Day1a.hs
RUN ghc -o day1b ./Day1b.hs
RUN ghc -o day2a ./Day2a.hs
RUN ghc -o day2b ./Day2b.hs
RUN ghc -o day3a ./Day3a.hs
RUN ghc -o day3b ./Day3b.hs
ENTRYPOINT []
CMD ["./day2b"]