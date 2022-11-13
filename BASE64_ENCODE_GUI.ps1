# DATE [2021-08-10] #
# 로그인, 파일 텍스트 난독화 · 복호화 기능
# [BASE64 + 치환] 기반 난독화 스크립트
# 2 번 파일은 AES 암호화 스크립트
# 회원가입 시 비밀번호를 sha256 암호화, DB 저장
# 로그인 시 입력한 비밀번호를 sha256 암호화, DB 비밀번호와 일치 시 Login Success.
# Authentication 기능은 인트라넷 특성상 DBMS 사용이 용이하지 않고, 데이터 수가 적으므로 csv 혹은 txt 방식의 DB 를 사용함.

Add-type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.drawing

$Lock_total = 0
$Activate_total = 0

function Lock {
foreach ($Accounts in get-content "C:\Users\CKIRUser\Documents\aa.txt") {
    $ID = (echo "$accounts").split("")[0]
    $PW = (echo "$accounts").split("")[1]
    $Status = (echo "$accounts").split("")[2]
        if ($Status -match "잠금") {
            $outputbox.Text = "$ID"
            $Lock_total = $Lock_total + 1
        }
        if ($Lock_total -eq 0) {
        $outputbox.Text = "잠긴 계정이 없습니다."
        }
    }
}


#로그인 체크
function Check {
$Load = findstr /i /c:"$IDbot.text" "C:\Users\CKIRUser\Documents\aa.txt"
foreach ($Load in get-content "C:\Users\CKIRUser\Documents\aa.txt") {
    $ID = (echo "$Load").split("")[0]
    $PW = (echo "$Load").split("")[1]
    $Status = (echo "$Load").split("")[2]
}
if ($PWbox.Text -ine $PW) {
        [System.Windows.Forms.MessageBox]::Show('아이디 혹은 비밀번호가 일치하지 않습니다.')  
    }
    if ($Status -match "Lock") {
        [System.Windows.Forms.MessageBox]::Show('계정이 잠겨있습니다.')  
    }
    if ($PWbox.Text -ieq $PW) {
        [System.Windows.Forms.MessageBox]::Show('접속 성공.')  
        $Login_Form.hide()
        $Main_Form.ShowDialog()
    }
}

# 로그인 폼
$Login_Form                            = New-Object system.Windows.Forms.Form
$Login_Form.ClientSize                 = New-Object System.Drawing.Point(390,350)
$Login_Form.text                       = ":: Build 2.0V ::"
$Login_Form.TopMost                    = $false
$Login_Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Login_Form.ControlBox = $false
$Login_Form.AutoSizeMode = "GrowAndShrink"
$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$Login_Form.StartPosition = $CenterScreen; 
$Login_Form_Icon = New-Object system.drawing.icon ("C:\Users\CKIRUser\Downloads\aa.ico")
$Login_Form.Icon = $objIcon


$ToolTip1                        = New-Object system.Windows.Forms.ToolTip
$ToolTip1.ToolTipTitle           = "종료"
$Exit                            = New-Object system.Windows.Forms.Label
$Exit.text                       = "X"
$Exit.AutoSize                   = $true
$Exit.width                      = 25
$Exit.height                     = 10
$Exit.location                   = New-Object System.Drawing.Point(351,3)
$Exit.Font                       = New-Object System.Drawing.Font('Modern No. 20',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Exit.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$Exit.add_click({
    $Login_Form.Close()
})

#Login Form 라벨
$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Login Form"
$Label1.AutoSize                 = $true
$Label1.width                    = 19
$Label1.height                   = 13
$Label1.location                 = New-Object System.Drawing.Point(109,19)
$Label1.Font                     = New-Object System.Drawing.Font('Modern No. 20',24,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Label1.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#000000")

#Username or ID 라벨
$label2                          = New-Object system.Windows.Forms.Label
$label2.text                     = "Username or ID"
$label2.AutoSize                 = $true
$label2.width                    = 25
$label2.height                   = 10
$label2.location                 = New-Object System.Drawing.Point(35,75)
$label2.Font                     = New-Object System.Drawing.Font('Microsoft YaHei UI',11)
$label2.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#999393")

#Password 라벨
$label3                          = New-Object system.Windows.Forms.Label
$label3.text                     = "Password"
$label3.AutoSize                 = $true
$label3.width                    = 25
$label3.height                   = 10
$label3.location                 = New-Object System.Drawing.Point(35,152)
$label3.Font                     = New-Object System.Drawing.Font('Microsoft YaHei UI',11)
$label3.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#999393")

#Forgot Password? 라벨
$label4                          = New-Object system.Windows.Forms.Label
$label4.text                     = "Forgot Password?"
$label4.AutoSize                 = $true
$label4.width                    = 25
$label4.height                   = 10
$label4.location                 = New-Object System.Drawing.Point(35,218)
$label4.Font                     = New-Object System.Drawing.Font('Modern No. 20',10)
$label4.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#000000")

#Not a Number? 라벨
$label5                          = New-Object system.Windows.Forms.Label
$label5.text                     = "Not a Member?"
$label5.AutoSize                 = $true
$label5.width                    = 25
$label5.height                   = 10
$label5.location                 = New-Object System.Drawing.Point(108,312)
$label5.Font                     = New-Object System.Drawing.Font('Modern No. 20',10)
$label5.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#000000")

#Signup Now 라벨
$label6                          = New-Object system.Windows.Forms.Label
$label6.text                     = "Signup Now"
$label6.AutoSize                 = $true
$label6.width                    = 25
$label6.height                   = 10
$label6.location                 = New-Object System.Drawing.Point(204,310)
$label6.Font                     = New-Object System.Drawing.Font('Microsoft YaHei UI',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Underline))
$label6.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#5f939a")
$Label6.add_click({
    $Register.Show
})


#로그인 버튼
$Login_Button                         = New-Object system.Windows.Forms.Button
$Login_Button.text                    = "LOGIN"
$Login_Button.width                   = 323
$Login_Button.height                  = 31
$Login_Button.Anchor                  = 'none'
$Login_Button.location                = New-Object System.Drawing.Point(35,250)
$Login_Button.Font                    = New-Object System.Drawing.Font('Modern No. 20',10)
$Login_Button.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Login_Button.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#5f939a")
$Login_Button.add_click({
    Check
})

#IDbox 텍스트 박스
$IDbox                        = New-Object system.Windows.Forms.TextBox
$IDbox.Text                   = ""
$IDbox.multiline              = $true
$IDbox.width                  = 323
$IDbox.height                 = 31
$IDbox.Anchor                 = 'bottom'
$IDbox.location               = New-Object System.Drawing.Point(35,100)
$IDbox.Font                   = New-Object System.Drawing.Font('Modern No. 20',11)
$IDbox.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$IDbox.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
        check
        $IDbox.text = ""
    }
})

#PWbox 텍스트 박스
$PWbox                        = New-Object system.Windows.Forms.TextBox
$PWbox.text                   = ""
$PWbox.multiline              = $true
$PWbox.width                  = 323
$PWbox.height                 = 31
$PWbox.Anchor                 = 'bottom'
$PWbox.location               = New-Object System.Drawing.Point(35,176)
$PWbox.Font                   = New-Object System.Drawing.Font('Modern No. 20',11)
$PWbox.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$PWbox.add_gotfocus({
if($PWbox.Text -eq ""){
            $PWbox.Text = ""
            $PWbox.PasswordChar = "*"
        }
})
$PWbox.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
        Check
        $PWbox.Text = ""
    }
})

#툴팁
$ToolTip1.SetToolTip($Exit,'클릭 시 종료됩니다.')
#기능 불러오기
$Login_Form.controls.AddRange(@($Label1,$Label2,$Label3,$Label4,$Label5,$Label6,$IDbox,$PWbox,$Login_Button,$exit))
#로그인 폼 불러오기
$Login_Form.showdialog()

# 메인 폼
#폼 생성
$Main_Form                            = New-Object system.Windows.Forms.Form
$Main_Form.ClientSize                 = New-Object System.Drawing.Point(560,710)
$Main_Form.TopMost                    = $false
$Main_Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Main_Form.AutoSizeMode = "GrowAndShrink"
$CenterScreen                     = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$Main_Form.StartPosition              = $CenterScreen; 



#파일 경로 라벨
$File_Patha                          = New-Object system.Windows.Forms.Label
$File_Patha.text                     = "파일 경로"
$File_Patha.AutoSize                 = $true
$File_Patha.width                    = 25
$File_Patha.height                   = 10
$File_Patha.location                 = New-Object System.Drawing.Point(13,11)
$File_Patha.Font                     = New-Object System.Drawing.Font('Modern No. 20',10)
$File_Patha.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$PathBox2                             = New-Object System.Windows.forms.Textbox
$PathBox2.Location                    = New-Object system.drawing.size(11,31)
$PathBox2.Size                        = New-Object System.Drawing.size(264,20)

Function File {
    $Input = $Pathbox2.Text
    Set-Location $Input
    $Com = get-childitem -file "$input"
    foreach($list in $com) {
        $Combo.Items.Add("$list")
    }
}

Function DFile {
    $Input = $Pathbox2.Text
    Set-Location $Input
    $Com = get-childitem -filter *.encode "$input"
    foreach($list in $com) {
        $Combo.Items.Add("$list")
    }
}

Function EFile {
    $Input = $Pathbox2.Text
    Set-Location $Input
    $Com = get-childitem -filter *.txt "$input"
    foreach($list in $com) {
        $Combo.Items.Add("$list")
    }
}

Function Encoding {
            $Decode.Checked = $False
            $original_load = get-content ".\$check_list"
            $Original_Value.Text = $original_load
       foreach ($xx in $Check_list) {
            $TEXT = get-content ".\$xx"
            $ENCODED = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($TEXT))
            $xd = $xx -creplace '.txt', ''
            $ENCODED > ".\$xd.encode"
            $Change_Value.text = $ENCODED
        }
}

Function Decoding {
       $Encode.Checked = $False
       $encode_load = get-content ".\$check_list"
       $Original_Value.Text = $encode_load
       $xx = "$Check_list"
       $TEXT = get-content ".\$xx"
       $DECODED = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($TEXT))
       $Change_Value.text = $DECODED
}
Function DecodingSave {
       $Encode.Checked = $False
       $encode_load = get-content ".\$check_list"
       $Original_Value.Text = $encode_load
      foreach ($xx in "$Check_list") {
       $TEXT = get-content ".\$xx"
       $xxx = $xx -creplace '.encode', ''
       $DECODED = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($TEXT))
       $DECODED > ".\$xxx.txt"
       }
}

#추출 버튼
$Path_B = New-Object System.Windows.Forms.Button
$Path_B.Text = "불러오기"
$Path_B.Location = New-Object system.drawing.size(205,55)
$Path_B.Size = New-Object system.drawing.size(70,25)
$Path_B.add_click({
    $Combo.Items.Clear()
    File
})

#Execute 버튼
$Execute_Button                         = New-Object system.Windows.Forms.Button
$Execute_Button.text                    = "Execute"
$Execute_Button.width                   = 63
$Execute_Button.height                  = 33
$Execute_Button.Anchor                  = 'none'
$Execute_Button.location                = New-Object System.Drawing.Point(215,166)
$Execute_Button.Font                    = New-Object System.Drawing.Font('Modern No. 20',10)
$Execute_Button.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Execute_Button.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#4A90E2")
$Execute_Button.Add_Click({
    if ($Encode.checked -ieq $True) {
        Encoding
       [System.Windows.Forms.MessageBox]::Show('난독화 완료.')
    } 
      #  $Original_data = ".\$Combo.SelectedItems"
       # $Original_Value.text = $Original_Value
    #}

    if ($Decode.checked -ieq $True) {
        Decoding
        [System.Windows.Forms.MessageBox]::Show('복호화 완료.')  
      }
})


#====================================

#리스트박스
$Combo                            = New-Object System.Windows.Forms.Listbox
$Combo.location                   = New-Object system.drawing.size(11,85)
$Combo.size                       = New-Object System.drawing.Size(196,122)
$Combo.SelectionMode = 'MultiExtended'
if ($Encode.Checked -ieq "$True") {
    $Combo.SelectionMode = 'MultiExtended'
}
if ($encode.Checked -ieq "$False") {
    $Combo.SelectionMode = ''
}
$Combo.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
        $combo2.items.clear()
        Check
    }
})


function Check {
    $x = $Combo.SelectedItems
    if ($Encode.checked -eq "$true") {
        foreach ($check_list in $x) {
            $Combo2.Items.Add("$check_list")
            Encoding
        }
    }
    if ($Decode.Checked -eq "$True") {
        $check_list = $Combo.SelectedItems
        $Combo2.Items.Add("$check_list")
        if ($combo.selecteditems -eq $check_list) {
         Decoding
       }
        if ($combo.selecteditems -ine $check_list) {
        [System.Windows.Forms.MessageBox]::Show('2개 이상 선택 불가')  
         }
         
}

}



#리스트박스
$Combo2                            = New-Object System.Windows.Forms.Listbox
$Combo2.location                   = New-Object system.drawing.size(300,85)
$Combo2.size                       = New-Object System.drawing.Size(196,122)
$Combo2.SelectionMode = 'MultiExtended'



#====================================

#=============백업 레이블

#백업 경로
$BK_Check                        = New-Object system.Windows.Forms.CheckBox
$BK_Check.text                   = "백업"
$BK_Check.AutoSize               = $false
$BK_Check.width                  = 73
$BK_Check.height                 = 20
$BK_Check.location               = New-Object System.Drawing.Point(220,131)
$BK_Check.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$BK_Check.Checked = $false
$BK_Check.add_Click({
if ($BK_Check.Checked -ieq $True) {
    $BK_File_Patha.show()
    $BKPath.show()
    $BK_Path_Select.show()
} else {
    $BK_File_Patha.hide()
    $BKPath.hide()
    $BK_Path_Select.hide()
}
})

$BK_File_Patha                          = New-Object system.Windows.Forms.Label
$BK_File_Patha.text                     = "백업 파일 저장 경로"
$BK_File_Patha.AutoSize                 = $true
$BK_File_Patha.width                    = 25
$BK_File_Patha.height                   = 10
$BK_File_Patha.location                 = New-Object System.Drawing.Point(296,131)
$BK_File_Patha.Font                     = New-Object System.Drawing.Font('Modern No. 20',10)
$BK_File_Patha.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$BK_File_Patha.hide()

$BKPath                             = New-Object System.Windows.forms.Textbox
$BKPath.Location                    = New-Object system.drawing.size(296,154)
$BKPath.Size                        = New-Object System.Drawing.size(166,20)
$BKPath.Hide()

$BK_Path_Select = New-Object System.Windows.Forms.Button
$BK_Path_Select.Text = "저장"
$BK_Path_Select.Location = New-Object system.drawing.size(400,180)
$BK_Path_Select.Size = New-Object system.drawing.size(63,25)
$BK_Path_Select.hide()
$BK_Path_Select.add_click({
    SaveBKPath
})

Function SaveBKPath {
    $SaveBKPath = $BKPath.Text
    $SaveBKPath > C:\users\CKIRUser\Documents\$ID_bkpath.txt
    [System.Windows.Forms.MessageBox]::Show('백업 폴더 저장 완료.')  
}



#====================================

#변환 레이블

#체크 박스 레이블
$Encode                       = New-Object system.Windows.Forms.CheckBox
$Encode.text                  = "난독화"
$Encode.AutoSize              = $false
$Encode.width                 = 69
$Encode.height                = 20
$Encode.location              = New-Object System.Drawing.Point(220,85)
$Encode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Encode.add_Click({
    $Combo.Items.Clear()
    $Decode.checked = $false
    EFile
})

$Decode                          = New-Object system.Windows.Forms.CheckBox
$Decode.text                     = "복호화"
$Decode.AutoSize                 = $false
$Decode.width                    = 69
$Decode.height                   = 20
$Decode.location                 = New-Object System.Drawing.Point(220,108)
$Decode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Decode.add_Click({
    $Combo.Items.Clear()
    $Encode.checked = $false
    DFile
})   


$Original_Value                  = New-Object system.Windows.Forms.TextBox
$Original_Value.multiline        = $true
$Original_Value.width            = 540
$Original_Value.height           = 210
$Original_Value.location         = New-Object System.Drawing.Point(11,247)
$Original_Value.Font             = New-Object System.Drawing.Font('Modern No. 20',11)
$Original_Value.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#f5a623")
$Original_Value.Scrollbars         = "both"

$Change_Value                    = New-Object system.Windows.Forms.TextBox
$Change_Value.multiline          = $true
$Change_Value.width              = 540
$Change_Value.height             = 210
$Change_Value.location           = New-Object System.Drawing.Point(10,489)
$Change_Value.Font               = New-Object System.Drawing.Font('Modern No. 20',11)
$Change_Value.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")
$Change_Value.Scrollbars         = "both"

$Main_Form.controls.AddRange(@($Combo,$PathBox2,$Path_B,$BK_Path_Select,$Original_Value,$encode,$decode,$bk_check,$BK_File_Patha,$Change_Value,$BKPath,$Execute_Button,$File_Patha,$combo2))
