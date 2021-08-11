import * as functions from "firebase-functions";

export const helloWorld = functions.https.onCall(async (data, context) => {
    return "Working";
});