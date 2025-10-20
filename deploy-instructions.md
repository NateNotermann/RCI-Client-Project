# AWS Deployment Instructions

## Prerequisites
1. AWS Account (free tier eligible)
2. AWS CLI installed: `brew install awscli`
3. Configure AWS CLI: `aws configure`

## Step 1: Create RDS PostgreSQL Database
```bash
# Create RDS instance (free tier)
aws rds create-db-instance \
  --db-instance-identifier rci-database \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username postgres \
  --master-user-password YourSecurePassword123 \
  --allocated-storage 20 \
  --vpc-security-group-ids sg-xxxxxxxxx \
  --publicly-accessible
```

## Step 2: Create S3 Bucket
```bash
# Create S3 bucket for images
aws s3 mb s3://rci-portal-images-unique-name

# Set bucket policy for public read
aws s3api put-bucket-policy --bucket rci-portal-images-unique-name --policy file://s3-policy.json
```

## Step 3: Deploy Backend to Elastic Beanstalk
```bash
# Install EB CLI
pip install awsebcli

# Initialize EB application
eb init rci-backend --platform node.js --region us-east-1

# Create environment
eb create rci-production --instance-type t3.micro

# Set environment variables
eb setenv DATABASE_URL="postgres://postgres:password@rds-endpoint:5432/client_project"
eb setenv AWS_ACCESS_KEY_ID="your-key"
eb setenv AWS_SECRET_ACCESS_KEY="your-secret"
eb setenv S3_BUCKET_NAME="rci-portal-images-unique-name"
eb setenv SERVER_SESSION_SECRET="JZ^Hu{;42X3mhYt`)e8FPV"

# Deploy
eb deploy
```

## Step 4: Deploy Frontend to Amplify
```bash
# Install Amplify CLI
npm install -g @aws-amplify/cli

# Initialize Amplify
amplify init

# Add hosting
amplify add hosting

# Publish
amplify publish
```

## Step 5: Setup Database Schema
```bash
# Connect to RDS and run databaseSetup.sql
psql -h your-rds-endpoint.region.rds.amazonaws.com -U postgres -d client_project -f databaseSetup.sql
```

## Environment Variables to Set:
- DATABASE_URL: Your RDS connection string
- newAWS_ACCESS_KEY_ID: Your AWS access key
- newAWS_SECRET_ACCESS_KEY: Your AWS secret key
- S3_BUCKET_NAME: Your S3 bucket name
- SERVER_SESSION_SECRET: Your session secret

## Costs (Free Tier):
- RDS: Free for 12 months (750 hours/month)
- EC2 (Elastic Beanstalk): Free for 12 months (750 hours/month)
- S3: Free (5GB storage, 20K GET requests)
- Amplify: Free (1000 build minutes, 15GB storage)