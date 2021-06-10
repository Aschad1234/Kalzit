$toDocument = "name" urlGetParameter $url propOf _request.
print: "Serving documentation for " + toDocument.

$unified = calcitUnifyName: toDocument.
!if (fileIsFile: "./docs/library/" + unified + ".md") {
	`Use the external documentation`
	asyncRef = true.
	"Location" ($setHeader propOf _request) "/docs/library/" + unified + ".md".
	($respondCode propOf _request): 301.
	!($endServing propOf _request).
}. !else {
	resultRef = "Oh no, no documentation was found for " + toDocument.
}