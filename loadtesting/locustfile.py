from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 3)  # Random wait between requests
    
    @task(1)
    def load_page(self):
        self.client.get("/")  # Replace with your endpoint

#   poetry run locust -f locustfile.py --host=http://34.244.237.231/