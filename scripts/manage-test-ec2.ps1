param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start", "stop", "status")]
    [string]$Action
)

$Region = "eu-west-3"
$InstanceName = "webmarket-test-web"

$InstanceId = aws ec2 describe-instances `
    --region $Region `
    --filters "Name=tag:Name,Values=$InstanceName" "Name=instance-state-name,Values=pending,running,stopping,stopped" `
    --query "Reservations[0].Instances[0].InstanceId" `
    --output text

if ($InstanceId -eq "None" -or [string]::IsNullOrWhiteSpace($InstanceId)) {
    Write-Host "Aucune instance trouvee avec le nom $InstanceName"
    exit 1
}

if ($Action -eq "stop") {
    aws ec2 stop-instances --instance-ids $InstanceId --region $Region
    Write-Host "Instance de test arretee : $InstanceId"
}

if ($Action -eq "start") {
    aws ec2 start-instances --instance-ids $InstanceId --region $Region
    Write-Host "Instance de test demarree : $InstanceId"
}

if ($Action -eq "status") {
    aws ec2 describe-instances `
        --instance-ids $InstanceId `
        --region $Region `
        --query "Reservations[0].Instances[0].State.Name" `
        --output text
}