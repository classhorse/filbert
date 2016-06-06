████████████████
█─█─█────██────█
█─█─█─██──█─██─█
█─█─█────██────█
█───█─██──█─██─█
██─██────██─██─█
████████████████


--LESSONS VBA

http://moonexcel.com.ua/sql-%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81-%D0%B8%D0%B7-excel-vba_ru

---------------------------------------------------------------------------

--курсы VBA 6500 rur.

http://www.specialist.ru/track/t-vba

---------------------------------------------------------------------------

--'Пустая строка через строку VBA
--'Для insert
    
Sub InsertRows()
Dim i As Long
For i = 2 To 200 Step 2
Cells(i, 3).EntireRow.Insert
Next i
End Sub

----------------------------------------------------------------------------

--телефоны в столбцы для SG

Sub Vse_tel_v_stro4ky()
a = 2
tel = 7
n = 1

Do Until IsEmpty(Worksheets("1").Cells(a, 1))
    id = CStr(Worksheets("1").Cells(a, 1))
    b = a
    n = 1
    tel = 7
    poz = a
    Do While CStr(Worksheets("1").Cells(b, 1)) = id
           Worksheets("1").Cells(poz, tel) = CStr(Worksheets("1").Cells(b, 4))
           b = b + 1
           tel = tel + 1
    Loop
   

    a = b
Loop
End Sub


А тебе нужно в обратном порядке сделать эту функцию. Т.е.
 Do Until IsEmpty(Worksheets("1").Cells(a, c))
................
c=c+1
 Loop


----------------------------------------------------------------------



Sub IncCell() 'Вставка доп.строки если в ячейке более 1 телефона

 Dim lastrow As Integer: Application.ScreenUpdating = False
  lastrow = ActiveSheet.UsedRange.Row - 1 + ActiveSheet.UsedRange.Rows.Count
 i = 2
'Убираем первый Enter и добавляем строки для телефонов, введенных через Enter
    Do While i <= lastrow
        cell = Cells(i, 2)
       ' cell.Select
        If Left(cell, 1) = Chr(10) Then Cells(i, 2) = Mid(cell, 2, Len(cell) - 1)
        If Right(cell, 1) = ";" Then cell = Left(cell, Len(cell) - 1)
        
        If InStr(1, cell, ";") > 0 Then
            Range(Cells(i + 1, 1), Cells(i + 1, 1)).EntireRow.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
            p = InStr(1, cell, ";", vbTextCompare)
            Cells(i + 1, 1) = Cells(i, 1)
            Cells(i + 1, 2) = Mid(cell, p + 1, Len(cell) - p)
            Cells(i, 2) = Mid(cell, 1, p - 1)
            lastrow = lastrow + 1
        End If
        i = i + 1
    Loop
   
End Sub




---------------------------------------------------------------

Option Explicit

Sub DB()

    Dim cn As ADODB.Connection
    Dim rs As ADODB.Recordset
    Dim strConn As String
    
    Set cn = New ADODB.Connection
    
   
    
    strConn = "Provider=SQLOLEDB.1;Password=12345;Persist Security Info=True;User ID=sa;Initial Catalog=i_collect;Data Source=192.168.11.15;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=CP-PERMYAKOVSV;Use Encryption for Data=False;Tag with column collation when possible=False"
    
    cn.Open strConn
    cn.Close
    Set cn = Nothing
    MsgBox "Connected!"

End Sub

