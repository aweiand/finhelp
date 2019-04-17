# README

Aplicação para auxílio na criação/manutenção do XML para assitência ao educando do financeiro do IFRS

A versão funcional no Campus Osório foi feita com:

* Ubuntu Server 16.04.1 LTS

* Ruby 2.3.1p112

* Apache 2.4.18

* PostgreSQL 9.5.10

* Phusion Passenger 5.0.30


Recomenda-se a edição dos arquivos:

* secrets.yml alterando as hashs necessárias

* database.yml

* .env.development deve ser editado e salvo como .env.production

* alteração de parâmetros padrão no arquivo seeds.rb para semear de acordo com as necessidades

* welcome_controller.rb - alterando usuário/senha "simples" de login


Para instalação das dependências:

* bundle install - dentro da pasta do projeto

* RAILS_ENV=production rake db:create - criando a base

* RAILS_ENV=production rake db:migrate - criando as tabelas

* RAILS_ENV=production rake db:seed - semeando dados de uso

* RAILS_ENV=production bundle exec rake assets:precompile - para compilar o CSS