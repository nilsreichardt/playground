package helloworld;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification.S3EventNotificationRecord;

public class S3EventProcessorHandler implements RequestHandler<S3Event, String> {

    public String handleRequest(S3Event s3event, Context context) {
        try {
            for (S3EventNotificationRecord record : s3event.getRecords()) {
                String s3Key = record.getS3().getObject().getKey();
                String s3Bucket = record.getS3().getBucket().getName();

                // Here, you can process the file or perform any other operations required.
                // For example, you could create a thumbnail, analyze the image, etc.

                context.getLogger().log("Processed file " + s3Key + " from bucket " + s3Bucket);
            }
            return "Successfully processed S3 event";
        } catch (Exception e) {
            e.printStackTrace();
            context.getLogger().log(String.format("Error processing S3 event: %s", e.getMessage()));
            throw new RuntimeException("Error processing S3 event", e);
        }
    }
}
