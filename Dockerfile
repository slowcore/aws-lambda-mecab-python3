FROM lambci/lambda:build-python3.6

COPY . .

RUN mkdir -p /var/task/lib
RUN curl -L "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -o mecab-0.996.tar.gz && \
    tar -zxvf mecab-0.996.tar.gz && \
    cd mecab-0.996 && \
    ./configure --prefix=/var/task/lib/mecab --with-charset=utf8 && \
    make && make install

RUN curl -L "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -o mecab-ipadic-2.7.0-20070801.tar.gz && \
    tar -zxvf mecab-ipadic-2.7.0-20070801.tar.gz && \
    cd mecab-ipadic-2.7.0-20070801 && \
    ./configure --prefix=/var/task/lib/mecab --with-charset=utf8 --with-mecab-config=/var/task/lib/mecab/bin/mecab-config && \
    make && make install

RUN pip3 install mecab-python3 -t /var/task/lib

CMD zip -r9 artifacts/deploy_package.zip lib
