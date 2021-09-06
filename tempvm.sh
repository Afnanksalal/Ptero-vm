docmd() {
    read -p "default@Ptero-vm:~ " CMD
    eval "$CMD"
    docmd2
}
docmd2() {
    read -p "default@Ptero-vm:~ " CMD2
    eval "$CMD2"
    docmd
}
