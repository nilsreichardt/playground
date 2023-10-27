package helloworld;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.events.S3Event;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification.S3BucketEntity;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification.S3Entity;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification.S3EventNotificationRecord;
import com.amazonaws.services.lambda.runtime.events.models.s3.S3EventNotification.S3ObjectEntity;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class S3EventProcessorHandlerTest {

    // Mock the Context interface
    @Mock
    private Context context;

    @Mock
    private LambdaLogger logger;

    @Before
    public void setUp() {
        // Initialize mocks created above
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testHandleRequest() {
        // Create and set up a mock S3 event
        S3EventNotificationRecord record = new S3EventNotificationRecord(
                "us-west-2",
                "ObjectCreated:Put",
                "aws:s3",
                "1970-01-01T00:00:00.000Z",
                "2.1",
                new S3EventNotification.RequestParametersEntity("127.0.0.1"),
                new S3EventNotification.ResponseElementsEntity("C3", "D3"),
                new S3Entity(
                        "testS3ConfigRule",
                        new S3BucketEntity("example-bucket", null, "123456789012"),
                        new S3ObjectEntity("test/key", 1024L, "eTag", "versionId"),
                        "1.0"),
                null);

        S3Event s3Event = new S3Event(Collections.singletonList(record));

        // Prepare the mocked logger to handle the log method call.
        doAnswer(invocation -> {
            // This is a mock of the behavior of the logger, printing to standard output
            Object arg0 = invocation.getArgument(0);
            System.out.println(arg0);
            return null; // Void methods need to return null in Mockito.
        }).when(logger).log(anyString());

        // Mock the getLogger method of the Context object
        when(context.getLogger()).thenReturn(logger);

        // Instantiate your Lambda function handler
        S3EventProcessorHandler handler = new S3EventProcessorHandler();

        // Execute your Lambda function handler
        String response = handler.handleRequest(s3Event, context);
        assertEquals(response, "Successfully processed S3 event");

        // Optionally, you can verify that the mocked methods were indeed called
        verify(context, times(1)).getLogger();
    }
}
