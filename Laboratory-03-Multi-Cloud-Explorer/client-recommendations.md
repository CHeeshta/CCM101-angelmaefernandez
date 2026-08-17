# Cloud Platform Recommendation

> **Laboratory 03 – Multi-Cloud Explorer**  
> **Checkpoint 4 – Cloud Platform Recommendation Challenge**

## Introduction

Different cloud providers have different strengths and services. The best choice depends on the client's budget, existing technology, workload, and future requirements. Based on the given scenarios, the following recommendations identify which cloud platform would be suitable for each client.

---

# Client A – Startup Company

### Scenario

A startup company wants to launch a new mobile application. Their budget is limited, but they expect rapid growth within the next few years.

### Recommended Cloud Platform

**Google Cloud Platform (GCP)**

### Recommendation

I would recommend GCP for this startup because it provides scalable resources that can support the application as the number of users increases. The company can start with the resources it needs and increase them when demand grows. GCP also provides services for computing, storage, databases, and application development. This can help the startup grow without needing to build and maintain its own physical infrastructure.

### Cloud Services the Client Could Use

1. **Compute Engine** – Provides virtual machines for running the mobile application's backend and other workloads.
2. **Cloud Storage** – Provides scalable storage for application files and other data.
3. **Cloud SQL** – Provides a managed relational database for application data.
4. **Google Kubernetes Engine (GKE)** – Can be used later if the application uses containerized services.

---

# Client B – University

### Scenario

A university already uses:

- Windows Server
- Microsoft 365
- Active Directory

The university wants to migrate some services to the cloud.

### Recommended Cloud Platform

**Microsoft Azure**

### Recommendation

I would recommend Microsoft Azure because the university already uses Microsoft technologies such as Windows Server and Microsoft 365. Azure is designed to work well with Microsoft environments and provides tools for managing users, servers, storage, and networks. This can make the migration easier because the university can continue using technologies that its IT staff are already familiar with. The university can also migrate its services gradually instead of moving everything at once.

### Cloud Services the Client Could Use

1. **Azure Virtual Machines** – Can be used to run Windows Server workloads in the cloud.
2. **Microsoft Entra ID** – Provides identity and access management for users and applications.
3. **Azure Storage** – Can store university files, backups, and other data.
4. **Azure Virtual Network** – Provides networking for cloud resources and connections to existing infrastructure.

---

# Client C – AI Research Company

### Scenario

A research company develops Artificial Intelligence and Machine Learning applications that require high-performance computing.

### Recommended Cloud Platform

**Google Cloud Platform (GCP)**

### Recommendation

I would recommend GCP because the company focuses heavily on Artificial Intelligence and Machine Learning. Google Cloud provides services specifically designed for developing, training, and deploying machine learning applications. It also provides scalable computing resources that can be used for demanding research workloads. These services can help the company experiment with AI models without having to purchase and maintain all of the required hardware.

### Cloud Services the Client Could Use

1. **Vertex AI** – Provides tools for developing, training, and deploying machine learning models.
2. **Compute Engine** – Provides scalable computing resources for research workloads.
3. **Cloud Storage** – Can store datasets, research files, and trained model data.
4. **BigQuery** – Can be used to analyze large datasets used by the research company.

---

# Client D – Global E-Commerce Company

### Scenario

A multinational online shopping company serves customers around the world and requires highly available infrastructure with automatic scaling.

### Recommended Cloud Platform

**Amazon Web Services (AWS)**

### Recommendation

I would recommend AWS because the company needs a cloud platform that can support customers in different parts of the world. AWS provides a large global infrastructure and services that can help applications remain available during high traffic. Automatic scaling can also increase or decrease computing resources based on demand. This would be useful for an e-commerce company that may experience large increases in traffic during sales and other busy periods.

### Cloud Services the Client Could Use

1. **Amazon EC2** – Provides virtual servers for running the company's applications.
2. **Amazon S3** – Provides object storage for files, images, backups, and other data.
3. **Elastic Load Balancing** – Distributes incoming traffic across application resources.
4. **Amazon EC2 Auto Scaling** – Automatically adjusts computing resources based on demand.
5. **Amazon RDS** – Provides a managed relational database for the company's applications.

---

# Overall Recommendations

| Client | Recommended Platform | Main Reason |
|---|---|---|
| **Client A – Startup Company** | **Google Cloud Platform** | Scalable services for a growing application |
| **Client B – University** | **Microsoft Azure** | Strong integration with Microsoft technologies |
| **Client C – AI Research Company** | **Google Cloud Platform** | Strong AI, ML, and computing capabilities |
| **Client D – Global E-Commerce Company** | **AWS** | Global infrastructure, availability, and automatic scaling |

## Conclusion

The best cloud provider depends on the specific requirements of each client. I recommend GCP for the startup because of its scalable services and GCP for the AI research company because of its AI and machine learning capabilities. Azure is a good choice for the university because it already uses Microsoft technologies, while AWS is suitable for the global e-commerce company because of its global infrastructure and automatic scaling capabilities.

Overall, a cloud engineer should consider the client's existing technology, budget, workload, scalability, and business requirements before choosing a cloud provider.
