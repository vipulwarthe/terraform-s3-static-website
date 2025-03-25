 #  Terraform AWS S3 Static Website Hosting

## Project Description:
In this project, I developed a streamlined infrastructure for hosting a static website using Terraform and Amazon Web Services (AWS) S3. The primary goal of this project is to demonstrate the automated provisioning and deployment of a web hosting solution for static websites.

## Overview:

![s3](https://github.com/mathesh-me/static-website-host-1/assets/144098846/ab68ff80-7841-4674-9b3c-ceac0710a39b)


## Key Components and Features:

### Terraform Infrastructure as Code (IaC):
I utilized Terraform, an IaC tool, to define and provision the AWS resources required for my static website hosting solution. This allows for version-controlled, repeatable infrastructure deployments.

### AWS S3 Bucket:
I created an S3 bucket to store and serve the static website files. This bucket is configured for website hosting, allowing for easy content delivery.

### Content Upload and Management: 
I provided instructions and scripts for uploading and managing my website content within the S3 bucket.

## Prerequisites:

1. Basic knowledge of AWS services and concepts.
2. Familiarity with Terraform and infrastructure as code principles.
3. An AWS account with appropriate permissions.
4. An IDE of your Choice , I would suggest VS Code Editor .
5. This project serves as an excellent foundation for hosting various types of static websites, including personal blogs, portfolio sites, or small business websites.


## Steps :

### Step 1: Set Up Your Development Environment

Install Terraform and the AWS Command Line Interface (CLI) on your local machine.
Configure your AWS credentials by running ```aws configure``` and providing your AWS access key and secret key.

### Step 2: Define Your Website Content

To prepare static website files (HTML), place them in the directory where your Terraform configuration files are located. Name the main HTML file "index.html," and optionally, you can also include an "error.html" file. If you prefer, you can reference my repository for the static website HTML files.

### Step 3: Terraform Configuration File Syntax

If we want to Create a terraform configuration file we have to use .tf (e.g., main.tf) to define the infrastructure as code using terraform.

### Step 4: Define your Configuration Files in your IDE
### Define the AWS provider and required resources like S3 buckets, IAM roles, and policies
1. Define ```provider.tf``` file using the below code :

```
provider "aws" {
    region = "us-east-1"
}
```
2. Define '''variables.tf''' file using the below code :

```
variable "aws_region" {
  description = "AWS region for S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
  default     = "ml-books-static-site"
}

variable "index_html" {
  description = "Path to the index.html file"
  type        = string
  default     = "index.html"
}

variable "error_html" {
  description = "Path to the error.html file"
  type        = string
  default     = "error.html"
}
```


3. In your Integrated Development Environment (IDE), open the terminal and navigate to the directory where you have created these configuration files.
4. After navigating to the directory where your configuration files are located in your IDE's terminal, you can run the following command to initialize Terraform and prepare it for use with AWS:

```shell
terraform init
```

Running `terraform init` will install the necessary plugins and modules required for connecting to AWS and managing your infrastructure.<br>

5. Then below command for creating the bucket :

```
terraform apply -auto-approve
```
6. And then add the below codes in __resource.tf__ file :
```
# Create S3 Bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = "ML Books Static Website"
    Environment = "Production"
  }
}

# Disable Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Enable Static Website Hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload index.html
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = var.index_html
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "error.html"
  source       = var.error_html
  content_type = "text/html"
}

# Public Read Policy (Allow access to all objects)
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
POLICY
}
```

7. And then again run the command :

```
terraform apply -auto-approve
```
8. The code above will apply the necessary configurations for features such as static website hosting, bucket policies, and blocking public access to your bucket.
9. Certainly, it's important to customize the code to your specific needs. Please remember to change the bucket name, region, and configurations as per your requirements when using the code from the Terraform documentation.

### Step 5: Define the Output file

1. We use an output file to obtain your website link in your IDE, eliminating the need to access the link through the AWS Console.
2. Define __output.tf__ file by using the below terraform code :
```
output "websiteendpoint" {
    value = aws_s3_bucket.bucket1.website_endpoint
  
}
```
3. And then run the following command :

```
terraform apply -auto-approve
```
4. It will give your website link as output as shown below

![s3](https://github.com/mathesh-me/static-website-host-1/assets/144098846/90551cc8-ed1e-45c3-91b1-ffcce24666e1)

### Step 6: Verify the Output 

Copy the link and paste it in your favourite browser.

![s4](https://github.com/mathesh-me/static-website-host-1/assets/144098846/f1908092-afeb-427b-a129-cc291275f4ae)

5. Run the following command to destroy the infrastructure after done your demo :

```
terraform destroy -auto-approve
```

6. How to push local Github repo into remote Github repo below are the step by step commands:

```
echo "# terraform-s3-static-website" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/vipulwarthe/terraform-s3-static-website.git
git push -u origin main
```

If it is faild to push the commit into repo then use below commands:

```
git status
git add .
git commit -m "files added"
git pull origin main --rebase         # use this command if faild to push commit
git push -u origin main
```


