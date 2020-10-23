function Get-SomeInput {
    $input = read-host "Please write yes or no and press Enter"

    switch ($input) `
    {
        'yes' {
            write-host 'You wrote yes'
        }

        'no' {
            write-host 'You wrote no'
        }

        default {
            write-host 'You may only answer yes or no, please try again.'
            Get-SomeInput
        }
    }
}

Get-SomeInput