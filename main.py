import requests

base_url = "http://www.omdbapi.com/"
params = {
    "apikey": "3da064a6",
    "t": "Vikings Blood Lust",
    # "Season": "13"
}

response = requests.get(base_url, params=params)
print(response.json())


# response = requests.post("https://myflixerz.to/ajax/search", "keyword=the+walking+dead")

# print(response.text)