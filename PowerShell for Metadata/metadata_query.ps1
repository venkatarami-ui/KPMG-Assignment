$metadata = Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "$MetadataURLdetails"

function Get-AzureInstanceMetadata {
    param (
        [string]$Key = ""
    )

    if (-not [string]::IsNullOrWhiteSpace($Key)) {
        return $metadata | Select-Object -ExpandProperty $Key
    } else {
        return $metadata
    }
}

# Example usage
$metadata = Get-AzureInstanceMetadata

# Convert to JSON format
$jsonOutput = $metadata | ConvertTo-Json -Depth 100

# Output JSON-formatted metadata
Write-Output $jsonOutput
