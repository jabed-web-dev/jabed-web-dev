function Local-Server {
    Param (
        [parameter(Mandatory = $true)]
        [ValidateSet(
            "developer.mozilla.org",
            "expressjs.com",
            "getbootstrap.com",
            "mongoosejs.com",
            "nodejs.lern",
            "nodejs.org",
            "reactjs.org",
            "tailwindcss.com",
            "w3schools.com",
			"sass-lang.com"
        )]
        [String]$Web
    ) 

    $WebDir = "D:\My-Web-Sites\$Web"
    if ($Web -eq "developer.mozilla.org") {
        npm start --prefix $WebDir
    }
    else {
        live-server --root=$WebDir --port=80 --host="local.$Web"
    }
}
