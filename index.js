var admin = require("firebase-admin");

const projectId = process.env.GCLOUD_PROJECT;

var serviceAccount = require(process.env.GOOGLE_APPLICATION_CREDENTIALS);

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: `https://${projectId}-default-rtdb.europe-west1.firebasedatabase.app/`,
});

var db = admin.database();
var ref = db.ref("/public_resource/");
ref.set("Hello World");

console.log("Updated.");