# xlo_mobx

## Getting Started
Este projeto está adaptado para o Flutter 2.0 sem null safety.
Os pacotes estão atualizados para as versões mais recentes dos packages, com exceção do Mobx.

Os packages necessários para o Mobx não podem ser atualizados para versões mais novas, pois o 
projeto não está com null safety.
São os packages:
- mobx
- flutter_mobx
- build_runner
- mobx_codegen
- build_resolvers 

Se forem atualizadas o projeto deve ser totalmente convertido para null safety.

Os MaterialButtons depreciados foram substituídos pelos da nova versão.
Foram criados dois widgets ReplaceFlatButton e ReplaceRaisedButton que encapsulam
as alterações para os widgets TextButton e ElevatedButton, para evitar alterações em todos os pontos
que possuem os MaterialButtons no código.

Este projeto está pré-configurado com:
* Back4app (Parse server) - https://www.back4app.com/
* Onesignal para envio de Notificações  - https://www.onesignal.com
* Facebook Login - https://developers.facebook.com/apps


É necessário atualizar as credenciais de acesso para o projeto rodar, pois as chaves informadas estão inválidas:
* Back4app - main.dart (chaves de acesso e endereço do LiveQuery, instruções abaixo)
* Onesignal - main.dart
* Facebook Login - Configuração no projeto nativo, conforme instruções do https://facebook.meedu.app/#/

* Back4app
Pegar as chaves conforme instrucões: https://www.back4app.com/docs/platform/app-settings
    
* Onesinal
Verificar o guia de configuração do Onesignal com o Flutter para obter as chaves de acesso e REST API KEY:
que é utilizada para enviar a notificação pelo Parse
https://documentation.onesignal.com/docs/flutter-sdk-3xx-setup
https://documentation.onesignal.com/docs/accounts-and-keys#section-app-id

É preciso criar um projeto no Firebase para obter a Google Api key
https://documentation.onesignal.com/docs/generate-a-google-server-api-key

* Back4app
Necessário ativar a LiveQuery e configurar o domínio:

Antes de ativar LiveQuery, necessáio criar duas classes novas sem campos adicionais.
São elas:
- ChatRoom
- Messages

Marcar as duas classes, quando configurar o LiveQuery, conforme o link
https://www.back4app.com/docs/platform/parse-live-query

Atualizar no main.dart a constante `serverLiveQueryURL` com a url configurado no Back4app.

Fazer deploy do Cloud Code que será responsável pelo envio de notificações e agendar o job.
O código do Cloud Code está na pasta `cloud` do projeto.
Antes é necessário atualizar no Cloud Code as chaves do projeto Back4app e Onesinal, nas primeiras linhas do arquivo:

Instruções para fazer deploy do código e agendar o job aqui:
https://www.back4app.com/docs/platform/parse-cron-job
