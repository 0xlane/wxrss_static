# PowerShell script to save webpage content to Git and commit every 10 minutes

# Loop indefinitely until the script is manually stopped
while ($true) {
    Write-Host "----------------------------------"
    Write-Host "Starting git operations..."

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
	Get-Date
    Write-Host "10 minutes passed, preparing for the next download"
}

Write-Host "Script started, running every 10 minutes. Press Ctrl+C to stop the script."