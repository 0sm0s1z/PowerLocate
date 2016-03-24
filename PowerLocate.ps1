function Get-GeoLocation {
<#
   .SYNOPSIS
      Returns system location information retrived via multiple mechanisms
      and displays results with accuracy estimates.
      Function: Get-GeoLocation
      Author: Matthew Toussain @0sm0s1z
      License: BSD 3-Clause
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      A location object including geocoords, city, state, and carrier.

   .EXAMPLE
      PS C:\> Get-GeoLocation
      Get system geolocation details.
      
   .LINK
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>


    Param(
        [Parameter(Position=0)]
        [Switch]
        $ToString
    )


   Invoke-IPGeoLocate
   Invoke-BSSIDGeoLocate


}


function Get-Location {
<#
   .SYNOPSIS
      Returns system location information retrived via public IP details
      and displays results.
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      A location object including geocoords, city, state, and carrier.

   .EXAMPLE
      PS C:\> Get-LocationSummary
      Get system geolocation details.
   .LINK
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>

   #With Location Provider
   # Windows Location API
   $mylocation = new-object –ComObject LocationDisp.LatLongReportFactory

   # Get Status 
   $mylocationstatus = $mylocation.status

}


function Invoke-IPGeoLocate {
<#
   .SYNOPSIS
      Returns system location information retrived via public IP details
      and displays results. This method does not utilize the Windows
      Location Provider.
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      A location object including geocoords, city, state, and carrier.

   .EXAMPLE
      PS C:\> Get-LocationSummary
      Get system geolocation details.
   .LINK
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>
}


function Invoke-BSSIDGeoLocate {
<#
   .SYNOPSIS
      Returns system location information retrived via netsh BSSID discovery
      and reverse lookup displays results with accuracy estimates. This method
      does not utilize the Windows Location Provider.
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      Assessed system geocoordinates based on nearby wireless access points and
      their strength.

   .EXAMPLE
      PS C:\> Invoke-BSSIDGeoLocate
      Get system geolocation details.
      
   .LINK
      http://www.openwlanmap.org/findmac.php?lang=en
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>



   
   
   
   #Without Location Provider

   $LocationObj = @{}

   #Get nearby BSSIDs
   netsh wlan show networks mode=bssid
   
   #Parse out BSSIDs
   $BSSID_SCAN = ""
   
   #For-Each
   foreach ($BSSID in $BSSID_SCAN)
   {
      #Lookup BSSID
      $res = webclient()

      $Key = $BSSID

      if (!$LocationObj.ContainsKey($Key))
      {
         $Properties = @{
             ESSID = $ESSID
             BSSID = $BSSID
             Power = $Power
             GeoLocation = $Coords
         }

         $Item = New-Object PSObject -Property $Properties
         $LocationObj.Add($Key, $Item)
      }
      else
      {
         pass
      }
      
      #Do Maths
      #Find GeoCoord in center
      $Coord = ""
   }
   
   
   #Resolve Address
   # Get Latitude and Longitude from LatlongReport property
   $latitude = $mylocation.LatLongReport.Latitude 
   $longitude = $mylocation.LatLongReport.Longitude

   if ($latitude -ne $null -or $longitude -ne $Null)
   {
     # Retrieve Geolocation from Google Geocoding API
     $webClient = New-Object System.Net.WebClient 
     Write-host "Retrieving geolocation for" $($latitude) $($longitude)
     $url = "https://maps.googleapis.com/maps/api/geocode/xml?latlng=$latitude,$longitude&amp;sensor=true"
     $locationinfo = $webClient.DownloadString($url) 

     [xml][/xml]$doc = $locationinfo
     # Verify the response
     if ($doc.GeocodeResponse.status -eq "OK")
     {
         $street_address = $doc.GeocodeResponse.result | Select-Object -Property formatted_address, Type | Where-Object -Property Type -eq "street_address" 
         $geoobject = New-Object -TypeName PSObject
         $geoobject | Add-Member -MemberType NoteProperty -Name Address -Value $street_address.formatted_address
         $geoobject | Add-Member -MemberType NoteProperty -Name latitude -Value $mylocation.LatLongReport.Latitude
         $geoobject | Add-Member -MemberType NoteProperty -Name longitude -Value $mylocation.LatLongReport.longitude
         $geoobject | format-list
     }
     Else
     {
         Write-Warning "Request failed, unable to retrieve Geo locatiion information from Geocoding API"  
     }



}


function Invoke-WiFiBeacon {
<#
   .SYNOPSIS
      Returns system location information retrived via multiple mechanisms
      and displays results with accuracy estimates.
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      A location object including geocoords, city, state, and carrier.

   .EXAMPLE
      PS C:\> Get-LocationSummary
      Get system geolocation details.
      
   .LINK
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>



}

function Invoke-AudioBeacon {
<#
   .SYNOPSIS
      Returns system location information retrived via multiple mechanisms
      and displays results with accuracy estimates.
    
   .DESCRIPTION
      This function performs system geolocation.

   .OUTPUTS 
      A location object including geocoords, city, state, and carrier.

   .EXAMPLE
      PS C:\> Get-LocationSummary
      Get system geolocation details.
   .LINK
      http://kinozoa.com/blog/PowerLocate/
      https://github.com/0sm0s1z/PowerLocate/PowerLocate.git
#>


   #BEEP
   
   
   #SOUND FULL VOLUME PLAY Win95 STARTUP SOUND

}