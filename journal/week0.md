# Week 0 — Billing and Architecture

## Getting Up and Running with CLI

### Installation of AWS CLI

This was a refresher since I've done it before, though in this sense I am being more deliberate and checking the different calls. For example, using `aws --cli-auto-prompt` enables the auto prompt in the online console for some sanity checks and debugging CLI commands like `aws sts get-caller-identity` to see my account info. This was super useful to grab AccountID. I could also map it to environment variables, though I didn't do that since I don't intend on using Gitpod or online terminals.

Instead, I will be depending on my local laptop, and simply did a simple copy paste after the query to populate these values:

### Created an Admin User and Generate AWS Credentials

What I did:

- `Enable console access` for the user
- Create a new `Admin` Group and apply `AdministratorAccess`
- Create the user and go find and click into the user
- Click on `Security Credentials` and `Create Access Key`
- Choose AWS CLI Access
- Download the CSV with the credentials

## Enable Billing 

Unfortunately the Admin user still didn't have Billing/Cost Management access even despite the use of the policy, so had to do some digging. This article:

https://docs.aws.amazon.com/cost-management/latest/userguide/control-access-billing.html

said I had to do some additional toggling of the **Activate IAM Access** in the URL: `/billing/home#/account`. Enabling this fixed the issu and now the Admin user has the ability to see billing alarms.

When that was done I could create (and later double check) with:

```
aws budgets create-budget \
    --account-id ${AWS_ACCOUNT_ID} \
    --budget file://aws/json/budget.json \
    --notifications-with-subscribers file://aws/json/notifications-with-subscribers.json
```

## Creating a Billing Alarm

### Create SNS Topic

Next, I needed to create an SNS topic:

`aws sns create-topic --name billing-alarm`

which creates the `TopicArn` before using the subscribe feature and confirming via email

```
aws sns subscribe \
    --topic-arn=TopicArn \
    --protocol=email \
    --notification-endpoint=email
```

then created the alarm

`aws cloudwatch put-metric-alarm --cli-input-json file://aws/json/alarm-config.json`

### Created an Organization and units for departments

1) LOok up what CloudTrail is:
- datasync? how it's used?
understand Region versus AZ versus Global Service
- this creates an s3 bucket

- Three kinds of AWS Users: IAM Users (you and me), Federated/System Users, 

HOMEWORK automation:
- Read about Service Control Policies (SCP) Some policies:
https://github.com/hashishrajan/aws-scp-best-practice-policies/tree/main/AWS%20SCP%20Policies
- Create a policy and attach to user: Attach a service policy to the users within an account

- create a group like read-only and attach policies for read only to it for s3 buckets. Pretend it's support techs/engineers.
- create Engineer group; should access EC2 iwthin that group. Only there.
- create a role

