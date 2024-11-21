# jupyter_data_analysis_generic

Image for general data science workflows.

## Installation and Usage

### Prerequisites

- Docker installed on your machine.

### Steps to Set Up

1. **Build the Docker Image**
   Navigate to your project directory where the Dockerfile is located and run the following command:
   ```bash
   docker build -t data_analysis:v1 .
   ```

   Then, run the built docker container:
   ```bash
   docker run -d -p 8888:8888 data_analysis:v1
    ```

   ```bash
   # Run and build:
   sh ./src/build_run.sh
   ```
   
   If all goes well, you will see a stream of logs confirming your docker container is running. 
   Look for the url starting with http://127.0.0.1:8888 in the logs and copy and paste into a new browser window.
   Then you can access all analysis notebooks needed for data analysis.

