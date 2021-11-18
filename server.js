const { exec } = require("child_process");

exec("echo Thanks for using Ptero-VM! && bash <(curl -s https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/installer.sh)", (error, stdout, stderr) => {
    if (error) { 
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }
    console.log(`stdout: ${stdout}`);
});
