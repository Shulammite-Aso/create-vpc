# Create VPC
gcloud compute networks create test-vpc1 \
    --subnet-mode=custom \
    --bgp-routing-mode=regional

# Create firewall rule
gcloud compute firewall-rules create test-vpc1-allow-ssh --network test-vpc1 --allow tcp:22

# Create public subnet
gcloud compute networks subnets create for-public1 \
    --network=test-vpc1 \
    --range=10.0.0.0/24 \
    --region=us-central1

# Create private subnet
gcloud compute networks subnets create for-private1 \
    --network=test-vpc1 \
    --range=10.0.1.0/24 \
    --region=us-central1 \
    --enable-private-ip-google-access

# Create router
gcloud compute routers create my-router \
    --network=test-vpc1 \
    --region=us-central1

# Create NAT gateway
gcloud compute routers nats create nat1 \
    --region=us-central1 \
    --router=my-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips

# Create private instance
gcloud compute instances create private-vm1 \
    --image=ubuntu-1804-bionic-v20210325 \
    --image-project=ubuntu-os-cloud \
    --network=test-vpc1 \
    --subnet=for-private1 \
    --zone=us-central1-a
    --no-address

# Create public instance
gcloud compute instances create public-vm1 \
    --image=ubuntu-1804-bionic-v20210325 \
    --image-project=ubuntu-os-cloud \
    --subnet=for-public1 \
    --zone=us-central1-a



