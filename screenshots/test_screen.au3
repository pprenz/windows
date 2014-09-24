#include <IE.au3>
#include <ScreenCapture.au3>

$Url = 'http://so1live.com'
$User = 'BWalters'
$Pwd = 'fraggleRocks!'

$test = _IEAutoLogin($Url, $User, $Pwd)

Func _IEAutoLogin($sUrl, $sUsername, $sPwd)
 ;funkey 09.09.09

 _IEErrorNotify(False)
 _IEErrorHandlerRegister()


EndFunc