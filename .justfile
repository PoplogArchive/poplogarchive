
[private]
help:
    just --list

fetch:
    git clone --depth=1 https://github.com/getpoplog/paradigms_lectures
    git clone --depth=1 https://github.com/getpoplog/popracer
    git clone --depth=1 https://github.com/getpoplog/Scheme
    git clone --depth=1 https://github.com/getpoplog/examples
    git clone --depth=1 https://github.com/getpoplog/abbott && (cd abbott && make build)

update:
    (cd paradigms_lectures && git pull https://github.com/getpoplog/paradigms_lectures)
    (cd popracer && git pull https://github.com/getpoplog/popracer)
    (cd Scheme && git pull https://github.com/getpoplog/Scheme)
    (cd examples && git pull https://github.com/getpoplog/examples)
    (cd abbott && git pull https://github.com/getpoplog/abbott && make build)
