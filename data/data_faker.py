from faker import Faker
from pathlib import Path
from random import randint
import ndjson


N_CUSTOMERS = 50
N_SHOPS = 3

folder = Path(__file__).parent
faker = Faker()


def generate_customers(n=N_CUSTOMERS):
    customers = []
    for _ in range(n):
        customer = faker.simple_profile()
        customer["birthdate"] = faker.date_of_birth(maximum_age=70, minimum_age=18)
        customer["birthdate"] = customer["birthdate"].strftime("%Y-%m-%d")
        customer["purchases"] = randint(0, 10)
        customer["shop_id"] = randint(0, N_SHOPS)
        customers.append(customer)
    return customers


def generate_shops(n=N_SHOPS):
    shops = []
    for i in range(n):
        shops.append({"id": i, "shop_name": f"Shop_{i}"})
    return shops


def generate_json(customers, shops):
    with open(folder / "customers.ndjson", "w") as datafile:
        lines = ndjson.dumps(customers)
        datafile.writelines(lines)

    with open(folder / "shops.ndjson", "w") as datafile:
        lines = ndjson.dumps(shops)
        datafile.writelines(lines)


if __name__ == "__main__":
    customers = generate_customers()
    shops = generate_shops()
    generate_json(customers, shops)
