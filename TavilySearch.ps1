using namespace System.Net

param($Request, $TriggerMetadata)

# Foundry parse automatiquement le body en hashtable
$query = [string]$Request.Body.query

$payload = @{
    api_key      = "Your Tavilty API KEY"
    query        = $query
    search_depth = "basic"
    max_results  = 5
} | ConvertTo-Json

$response = Invoke-RestMethod -Uri "https://api.tavily.com/search" -Method Post -Body $payload -ContentType "application/json"

$results = $response.results | Select-Object title, url, content

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body       = ($results | ConvertTo-Json)
})
