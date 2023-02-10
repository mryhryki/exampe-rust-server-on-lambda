import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx";

const lambdaRole = new aws.iam.Role("example-rust-server-on-lambda-role", {
  assumeRolePolicy: {
    Version: "2012-10-17",
    Statement: [{
      Action: "sts:AssumeRole",
      Principal: {
        Service: "lambda.amazonaws.com",
      },
      Effect: "Allow",
      Sid: "",
    }],
  },
});
new aws.iam.RolePolicyAttachment(
  "example-rust-server-on-lambda-policy-attachment",
  {
    role: lambdaRole,
    policyArn: aws.iam.ManagedPolicies.AWSLambdaExecute,
  },
);

const lambdaFunction = new aws.lambda.Function(
  "example-rust-server-on-lambda",
  {
    packageType: "Image",
    imageUri: process.env.ECR_URI,
    role: lambdaRole.arn,
  },
);
