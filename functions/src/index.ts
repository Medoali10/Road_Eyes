import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('data/DATA')
  .onUpdate( async (change, context) => {

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'crash',
        body: `there is a car crash`,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK', // required only for onResume or onLaunch callbacks
      },
    };
if(change.after.data()['crash'] == true){
    return fcm.sendToTopic('puppies', payload);
}else{
   return
}
  });