<#
.SYNOPSIS
This script is designed to return the flavor of the day at the Culvers restaurant specified by the user.
.DESCRIPTION
Just a script I wrote for fun to get the flavor of the day from a culvers restaurant. You know, the important stuff.
.PARAMETER restaurantURL
This is the portion of the restaurant URL for the store you wish to check - you'll need to get this from their website Ex: wake-forest-nc-rogers-rd from https://www.culvers.com/restaurants/wake-forest-nc-rogers-rd
.NOTES
Initial Release: 3-20-19
Author: Brandon Sabol (@bmsabol)
.EXAMPLE
culversfotd.ps1 -restaurantURL wake-forest-nc-rogers-rd
#>
param (
    [Parameter(Mandatory=$true)]
    [string]$restaurantURL
)

$url = "https://www.culvers.com/restaurants/$restaurantURL"
$classname = 'ModuleRestaurantDetail-fotd'

Try {
    Write-Host "Connecting to the internets to check restaurant: $restaurantURL"
    $result = Invoke-WebRequest $url
}
Catch {
    Write-Host "Unable to reach the URL for the specified restaurant. Please check to ensure you input the correct URL and try again." -ForegroundColor Green
    
}

Try{ 
    $fotd = $result.ParsedHtml.body.getElementsByClassName($classname) | Select-Object -expand textContent
    Write-Host $fotd
}
Catch {
    Write-Host "Cannot retrieve the flavor of the day for the specified restaurant. Many sads were had." -ForegroundColor Green
}