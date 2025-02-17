# PowerShell script to save webpage content to Git and commit every 10 minutes

# Set the URLs to download (using an array)
$urls = @(
    "http://localhost:8080"
    "http://localhost:8080/rss.xml"
)

# Set the save paths and filenames (using an array, corresponding to URLs)
$savePaths = @(
    ".\index.html"
    ".\rss.xml"
)

# Loop indefinitely until the script is manually stopped
while ($true) {
    Write-Host "----------------------------------"
    Write-Host "Starting a new round of download and Git operations..."

    # Loop through URLs and SavePaths arrays
    for ($i = 0; $i -lt $urls.Count; $i++) {
        $url = $urls[$i]
        $savePath = $savePaths[$i]

        curl.exe $url -o $savePath
    } # End of for loop (URLs iteration completed)

    # Check if any webpage was downloaded successfully (simplified handling: Git is executed if the loop didn't completely fail)
    # For more robust handling, you can track successful downloads and execute Git only if at least one download succeeded.

    Write-Host "Executing git add, commit, push..."

    # Assuming the script is run from the Git project root directory, execute Git commands directly
    git add .
    git commit -m "update"
    git push

    Write-Host "Git operations completed"
    Write-Host "----------------------------------"


    # Wait for 10 minutes (600 seconds)
    Write-Host "Waiting for 10 minutes..."
    Start-Sleep -Seconds 600
    Write-Host "10 minutes passed, preparing for the next download"
}

Write-Host "Script started, running every 10 minutes. Press Ctrl+C to stop the script."