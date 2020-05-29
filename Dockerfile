FROM ruby:2.5.1-slim

#instala depencias
RUN apt update && apt install -qq -y --no-install-recommends \
    build-essential libpq-dev imagemagick curl

#instala GNUPG
RUN apt install -y gnupg

#instala o Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs

#instala o yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    apt update && apt install -y yarn

#configura path do projeto
ENV INSTALL_PATH /nosso_amigo_secreto

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

#configuração das gens
COPY Gemfile ./

#copia arquivos do projeto para o container
COPY . .