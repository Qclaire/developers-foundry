
from locust import HttpUser, task, between


class WebsiteUser(HttpUser):
    wait_time = between(1, 3)
    
    @task(1)
    def load_page(self):
        self.client.get("/")
















#   poetry run locust -f locustfile.py --host=http://54.171.191.190