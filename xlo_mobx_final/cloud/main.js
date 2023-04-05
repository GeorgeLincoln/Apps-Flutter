// Documentação do Cloud Clode
// https://docs.parseplatform.org/cloudcode/guide/

// Documentação do JavaScript para usar no Cloud Code
// https://docs.parseplatform.org/js/guide/

//Recuperar valores do Dashboard do Back4app
//https://www.back4app.com/docs/platform/app-settings
const PARSE_SERVER_APPLICATION_ID = '8MmuFHBcTejklfFhxsvS03gy0XIijosSQp6l5Da2';
const PARSE_SERVER_MASTER_KEY = '2DcS3x0CbMEklvKmDsvFw1OZ8t1484ldem4lCSMQ';

//Recuperar valores abaixo do Painel do OneSignal
//https://documentation.onesignal.com/docs/accounts-and-keys#section-app-id
const ONESIGNAL_APP_ID = '1e6872fc-edd2-47b6-a894-97bc55ae423e';
const ONESIGNAL_AUTHORIZATION_TOKEN = 'Basic NWYwNjlkOWMtNzVmNS00NzZiLThkM2UtZTlmNDliNmI1M2M4';

//--------------------------------------------------------------------------
//Job para ativação de anúncios e envio de push
//--------------------------------------------------------------------------
Parse.Cloud.job("adActivate", async (request) => {
  try {
    const queryAd = new Parse.Query("Ad");
    queryAd.equalTo("status", 0);

    const results = await queryAd.find({ useMasterKey: true });
    for (let i = 0; i < results.length; i++) {
      results[i].set("status", 1);
      results[i].save(null, { useMasterKey: true }).then(function (saveAd) {
        var title = 'Anúncio publicado';
        var message = 'Seu anúncio ' + saveAd.get('title') + ' foi publicado';
        var userId = saveAd.get('owner').id;

        const jsonBody = {
          app_id: ONESIGNAL_APP_ID,
          include_external_user_ids: [userId],
          headings: { "en": title },
          contents: { "en": message },
          data: { "adId": results[i].id }
        };

        sendNotification(jsonBody);
      })
    }
    return 'Número de anúncios ativados: ' + results.length;
  } catch (error) {
    console.error('Error: adActive' + error.message);
    throw new Error('Error: adActive' + error.message);
  }
})
//--------------------------------------------------------------------------
//Function para incrementar as visualizações dos anúncios
//--------------------------------------------------------------------------
Parse.Cloud.define('adIncrementViews', async (request) => {
  const query = new Parse.Query("Ad");

  query.get(request.params.id, { useMasterKey: true }).then(function (ad) {
    ad.increment("views");
    ad.save(null, { useMasterKey: true }).then(function () {
      console.log("success -> adIncrementViews");
    }, function (error) {
      console.error('Error: incrementViews' + error.message);
      throw new Error('Error: adIncrementViews' + error.message);
    });
  }, function (error) {
    throw new Error('adIncrementViews: Error: ' + error.code + ' : ' + error.message);
  });
})

//--------------------------------------------------------------------------
//Este function é chamado da apliação Flutter para atualizar o status de um anúncio
//--------------------------------------------------------------------------
Parse.Cloud.define('adMaintenance', async (request) => {

  console.log('adMaintenance: ' + request.params.id);
  console.log('adMaintenance: ' + request.params.status);

  const query = new Parse.Query("Ad");

  query.get(request.params.id, { useMasterKey: true }).then(function (ad) {
    ad.set('status', request.params.status);
    ad.save(null, { useMasterKey: true }).then(function () {
      console.log("success -> adMaintenance");
    }, function (error) {
      console.error('Error: incrementViews' + error.message);
      throw new Error('Error: incrementViews' + error.message);
    });
  }, function (error) {
    throw new Error('adMaintenance: Error: ' + error.code + ' : ' + error.message);
  });
})

//--------------------------------------------------------------------------
//Exclui os favoritos dos usuários quando o anúncio for vendido/excluído
//--------------------------------------------------------------------------
Parse.Cloud.afterSave("Ad", async (request) => {
  var ad = request.object
  var adId = request.object.id;
  var adStatus = request.object.get("status");

  console.log('Pesquisando Favoritos: ' + adId + ' / Status: ' + adStatus);
  if ((adStatus == 2) || (adStatus == 3)) {
    //Excluir favoritos associados ao AD
    var queryFavorites = new Parse.Query("Favorites");
    queryFavorites.equalTo("ad", request.object);
    const results = await queryFavorites.find({ useMasterKey: true });
    Parse.Object.destroyAll(results, { useMasterKey: true });
  }
  //Excluir imagens não estão mais associadas ao Anúncio
  console.log('Verificando imagens: ' + adId + ' / Status: ' + adStatus);
  const images = request.object.get('images');
  const imagesOriginal = request.original.get('images');
  if (imagesOriginal && images != imagesOriginal) {
    for (let i = 0; i < imagesOriginal.length; ++i) {
      var found = false;
      for (let j = 0; j < images.length; ++i) {
        if (images[i].url == imagesOriginal[j].url) {
          found = true;
        }
      }
      if (found == false) {
        deleteFile(imagesOriginal[i]);
      }
    }
  }
});

//------------------------------------------------------------------------------------
//Função chamada automaticamente quando o anúncio for excluído para remover as imagens
//------------------------------------------------------------------------------------
Parse.Cloud.beforeDelete('Ad', async (request) => {
  const images = request.object.get('images');
  if (images) {
    for (var i = 0; i < images.length; ++i) {
      deleteFile(images[i]);
    }
  }
});

//------------------------------------------------------------------------------------
//Função chamada automaticamente quando o Chat for excluído para remover as mensagens
//------------------------------------------------------------------------------------
Parse.Cloud.beforeDelete('ChatRoom', async (request) => {
  const chatRoom = request.object;
  console.log('Excluindo messages ChatRoom:' + JSON.stringify(chatRoom));

  var queryMessages = new Parse.Query("Messages");
  queryMessages.equalTo("chatRoom", chatRoom);
  const results = await queryMessages.find({ useMasterKey: true });
  console.log('Quantidade de mensagens excluídas: ' + results.length);

  Parse.Object.destroyAll(results, { useMasterKey: true });
});

//------------------------------------------------------------------------------------
//Função chamada automaticamente quando a mensagem é salva, disparando o envio do push
//------------------------------------------------------------------------------------
Parse.Cloud.beforeSave('Messages', async (request) => {
  //Mensagem nova
  if (request.object.isNew()) {
    //recupera os dados da mensagem
    const destinationId = request.object.get('destinationId');
    const messageText = request.object.get('messageText');
    const chatRoomId = request.object.get('chatRoom').id;

    //Cria um objeto ChatRoom para chamar o Pointer
    const ChatRoom = Parse.Object.extend('ChatRoom');
    const chatRoom = new ChatRoom();
    chatRoom.id = chatRoomId;

    //Recupera a chatRoom
    const chatRoomQuery = new Parse.Query('ChatRoom');
    chatRoomQuery.include('ad');
    try {
      const resultChatRoom = await chatRoomQuery.get(chatRoomId, { useMasterKey: true });
      if (resultChatRoom != null) {
        resultChatRoom.set('lastMessage', messageText);
        resultChatRoom.increment('numMessage');

        const adTitle = resultChatRoom.get('ad').get('title');

        await resultChatRoom.save(null, { useMasterKey: true });
        console.log('ChatRoom updated: ' + resultChatRoom.id);

        const title = adTitle;
        const message = 'Nova mensagem : ' + messageText;

        const jsonBody = {
          app_id: ONESIGNAL_APP_ID,
          include_external_user_ids: [destinationId],
          headings: { "en": title },
          contents: { "en": message },
          android_group: chatRoomId,
          android_group_message: { "en": "Você tem $[notif_count] novas mensagens" },
          thread_id: chatRoomId,
          data: { "chatRoomId": chatRoomId }
        }

        sendNotification(jsonBody);
      } else {
        console.log('Chat nof found');
        throw new Error('Chat foi excluído');
      }
    } catch (error) {
      console.error('Error: chatRoom Updated:' + error.message);
      throw new Error('Error: chatRoom Updated: ' + error.message);
    }
  }
})

//------------------------------------------------------------------------------------
//Função que envia a notificação utilizando o Onesignal
//------------------------------------------------------------------------------------
async function sendNotification(notificationData) {
  console.log('notificationData' + JSON.stringify(notificationData));
  try {
    const response = await Parse.Cloud.httpRequest({
      url: 'https://onesignal.com/api/v1/notifications',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        "Authorization": ONESIGNAL_AUTHORIZATION_TOKEN
      },
      body: JSON.stringify(notificationData),
    });
    console.log('Notification was sent successfully.');
  } catch (error) {
    console.error('Notification failed to send with error: ' + error.text);
  }
  return;
}

//------------------------------------------------------------------------------------
//Função para excluir arquivos que não sendo mais utilizados
//------------------------------------------------------------------------------------
async function deleteFile(file) {
  console.log('Arquivo para excluir: ' + JSON.stringify(file));
  var split_url = file.url().split('/');
  var filename = split_url[split_url.length - 1];

  //Exclusão de arquivo não funciona com Back4App.
  //Será necessário verificar com o suporte
  /*
  try {
    await Parse.Cloud.httpRequest({
      url: file.url(),
      method: 'DELETE',
      headers: {
        'X-Parse-Master-Key': PARSE_SERVER_MASTER_KEY,
        'X-Parse-Application-Id': PARSE_SERVER_APPLICATION_ID
      }
    });
    console.log('Success delete file ' + file.url());
  } catch (error) {
    console.log('Failed delete file ' + file.url() + ': ' + error.text);
  }
  */

}
