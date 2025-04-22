https://www.who.int/data/gho/info/gho-odata-api


import requests

# Define API endpoint
url = "https://ghoapi.azureedge.net/api/NCD_BMI_30A"
params = {
    "$filter": "SpatialDim eq 'JPN' and TimeDim ge 2010 and TimeDim le 2020"
}

# Make the request
response = requests.get(url, params=params)
print("Status Code:", response.status_code)

# Parse the data
if response.status_code == 200:
    data = response.json()
    records = data['value']

    # Sort by year (optional)
    records.sort(key=lambda x: x['TimeDim'])

    for record in records:
        print(f"Year: {record['TimeDim']}, Obesity Prevalence: {record['Value']}%")
else:
    print("Error:", response.text)
