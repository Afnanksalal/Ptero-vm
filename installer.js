const { exec } = require("child_process");

exec("echo Thanks for using Ptero-VM! && curl -o installer.sh https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/installer.sh && chmod +x installer.sh && ./installer.sh", (error, stdout, stderr) => {
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
