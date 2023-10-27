# EIST Exercise Playground

## What is included?

* HTTP Lambda Function

## How to run locally

You have two options for running the AWS Lambda functions locally:
1. Using the [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
2. Using [LocalStack](https://github.com/localstack/localstack)

### Using the AWS SAM CLI

```bash
sam-app$ sam local invoke HelloWorldFunction --event events/event.json
```

### Using LocalStack

#### HTTP Lambda Function

1. Start LocalStack
```bash
localstack start -d
```

2. Add `buildZip` task to `build.gradle`:
```gradle
task buildZip(type: Zip) {
    into('lib') {
        from(jar)
        from(configurations.runtimeClasspath)
    }
}
```

3. Build the Lambda function
```bash
./gradlew buildZip
```

4. Create the function
```bash
awslocal lambda create-function \
    --function-name java-eist-function \
    --runtime java17 \
    --zip-file fileb://build/distributions/HelloWorldFunction.zip \
    --handler helloworld.App \
    --role arn:aws:iam::000000000000:role/lambda-role
```

5. Invoke the function with `awslocal` CLI:
```bash
awslocal lambda invoke --function-name java-eist-function output.txt
```

6. To update the function, call:
```bash
awslocal lambda update-function-code \
    --function-name java-eist-function \
    --zip-file fileb://build/distributions/HelloWorldFunction.zip
```

#### S3 Lambda Function

1. Setting up LocalStack
```bash
awslocal s3api create-bucket --bucket sample-bucket
```

2. Deploy function:
```bash
./gradlew buildZip
awslocal lambda create-function \
    --function-name process-s3-event \
    --runtime java17 \
    --zip-file fileb://build/distributions/HelloWorldFunction.zip \
    --handler helloworld.S3EventProcessorHandler \
    --role arn:aws:iam::000000000000:role/lambda-role
```

3. Set up S3 Event Notifications:

```
{
    "LambdaFunctionConfigurations": [
        {
            "LambdaFunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:process-s3-event",
            "Events": [
                "s3:ObjectCreated:*"
            ]
        }
    ]
}
```

```bash
awslocal s3api put-bucket-notification-configuration \
  --bucket sample-bucket \
  --notification-configuration file://notification.json
```

4. Testing
```bash
IMAGE_PATH=/Users/nils/Downloads/image.jpg
awslocal s3 cp $IMAGE_PATH s3://sample-bucket
```

5. To update the function, call:
```bash
awslocal lambda update-function-code \
    --function-name  process-s3-event \
    --zip-file fileb://build/distributions/HelloWorldFunction.zip
```