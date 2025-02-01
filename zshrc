HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt hist_ignore_all_dups

source "$HOME/.cargo/env"

zstyle :compinstall filename '/home/Raj/.zshrc'
autoload -Uz compinit
compinit

### My Aliases
alias ip="ip --color=auto"
alias ls="eza --color=always --icons=always --no-user"
alias l="eza --long --color=always --icons=always --group"
alias la="eza --color=always --icons=always --group --all"
alias ll="eza --long --color=always --icons=always --group -alF"
alias diff='diff --color=auto'
alias bat='bat --color=always'
alias batn='bat --color=always --paging=never'
alias catb='bat --color=always'
alias catbc='bat --color=always --paging=never'
alias batc='clear; bat --paging=never'
alias grep="grep --color=auto"
alias dir="dir --color=auto"
alias MOD="rclone mount OneDrive:/ /home/Raj/OneDrive/ --daemon"
alias UOD="sudo umount /home/Raj/OneDrive/ --force"
alias ncdu="ncdu --color dark"
alias ncduc="clear; ncdu --color dark"
alias qemu="qemu-system-x86_64"
alias firefox-dev="firefox-developer-edition"
alias firefoxdev="firefox-developer-edition"
alias sways='clear; sway --unsupported-gpu 1> /dev/null 2>&1'
alias VimBeGood='clear; docker run -it --rm brandoncc/vim-be-good:stable && echo && clear'
alias CppDir='cd ~/DEV/GitRepos/C++/'
alias sourceme='source ~/.zshrc'
alias zshrc='clear; vim ~/.zshrc'
alias vimrc='clear; vim ~/.vimrc'
alias nvimrc='clear; nvim ~/.config/nvim/init.vim'
alias yazi='EDITOR=nvim yazi'
alias yazic='clear; EDITOR=nvim yazi'
alias vimc='clear; vim'
alias nvimc='clear; nvim'
alias btopc='clear; btop'
alias y='yazi'
alias yc='clear; yazi'
alias not_needed_pkg='pacman -Qtdq'
alias clearcache="sudo pacman -Scc && yay -Scc"
alias weather='curl wttr.in/24.5800,80.8369'
alias diff='colordiff'
alias nvtop='nvtop --delay 2'

### Flatpak Applications
alias scrivano="flatpak run com.github.scrivanolabs.scrivano"
alias draw="flatpak run com.github.scrivanolabs.scrivano"
alias tipp10="flatpak run com.gitlab.tipp10.tipp10"
alias ktouch="flatpak run org.kde.ktouch"
alias typing="flatpak run org.kde.ktouch"
alias easyeffects="flatpak run com.github.wwmm.easyeffects"
alias effects="flatpak run com.github.wwmm.easyeffects"
alias pomodoro="flatpak run org.jousse.vincent.Pomodorolm"
alias pomodorolm="flatpak run org.jousse.vincent.Pomodorolm"
alias discord="flatpak run com.discordapp.Discord"
alias calculator="flatpak run io.github.Qalculate.qalculate-qt"
alias qcal="flatpak run io.github.Qalculate.qalculate-qt"
export WINEPREFIX="/home/Raj/.wine"
export PATH="$PATH:/home/Raj/.path/:/home/Raj/.path/scripts:/home/Raj/.path/exercism"

function tor_proxy() {
    u_set="{$1:-"NULL"}"
    if [[ $u_set == "unset" ]]; then
        unset http_proxy
        unset https_proxy
        exit 0
    fi
    export http_proxy="socks5://127.0.0.1:9050"
    export https_proxy="socks5://127.0.0.1:9050"

}

function encode() {
    local input="$1"
    local should_save="$2"
    local output_file_name="$3"

    if [[ -d "$input" ]]; then
        echo "We don't accept directories"
    elif [[ -f "$input" ]]; then
        echo "This is the file: $input"
        [[ $should_save == "true" ]] && { cat "$input" | tr "A-Za-z" "N-ZA-Mn-za-m" > "$output_file_name"; } || \
            { cat "$input" | tr "A-Za-z" "N-ZA-Mn-za-m"; }
    else
        [[ $should_save == "true" ]] && { echo "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" > "$output_file_name"; } || \
            { echo "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" ; }
    fi
}

function decode() {
    local input="$1"
    local should_save="$2"
    local output_file_name="$3"

    if [[ -d "$input" ]]; then
        echo "We don't accept directories"
    elif [[ -f "$input" ]]; then
        echo "This is the file: $input"
        [[ $should_save == "true" ]] && { cat "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" > "$output_file_name"; } || \
            { cat "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" ; }
    else
        [[ $should_save == "true" ]] && { echo "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" > "$output_file_name"; } || \
            { echo "$input" | tr "N-ZA-Mn-za-m" "A-Za-z" ; }
    fi
}

function rot13() {
    local operation="$1"
    local input="$2"
    local should_save="$3"
    local output_file="$4"

    [[ $should_save == "-s" ]] && should_save="true" || should_save="false"

    if [[ $# -gt 1 ]]; then
       if [[ -d "$input" ]]; then
            echo "Only file and Strings are allowed"
       elif [[  -f "$input"  ]]; then
            if [[ $operation =~ ^(encode|e|-e)$ ]]; then
               encode "$input" "$should_save" "$output_file"
            elif [[ $operation =~ ^(decode|d|-d)$ ]]; then
               decode "$input" "$should_save" "$output_file"
            fi
       else
            if [[ $operation =~ ^(encode|e|-e)$ ]]; then
               encode "$input" "$should_save" "$output_file"
            elif [[ $operation =~ ^(decode|d|-d)$ ]]; then
               decode "$input" "$should_save" "$output_file"
            fi
       fi
    else
        echo "[ERROR]: At least two arguments expected"
        echo "rot13 <encode/decode> <file/string>"
    fi
}

function pretty() {
    local file="$1";
    echo "$file" |  sed 's/\[.*\]//g' | sed 's/ /_/g'
}

function JournalToday {
    local JournalFileName="${HOME}/Obsidian/Journal/date_$(date +%d-%b-%Y_).md"
    local green="\033[3;32m"
    local no_col="\033[0m"
    [[ ! -f  "${JournalFileName}" ]] && { touch "${JournalFileName}" ; echo "Created ${green}"${JournalFileName}"${no_col}" } || \
        {echo "File already exists: ${green}"${JournalFileName}"${no_col}";}
}

function extract() {
    local archive="$1"

    if [[ "${archive}" == *.tar  ]]; then
        tar -xvf "${archive}"
    elif [[ "${archive}" == *.tar.gz  ]]; then
        tar -xzvf "${archive}"
    elif [[ "${archive}" == *.tar.xz  ]]; then
        tar -xJvf "${archive}"
    elif [[ "${archive}" == *.tar.bzip2  ]]; then
        tar -xjvf "${archive}"
    else
        printf "Sorry this is not tar archieve"
    fi
}

function CompileC() {
    local file="$1"
    gcc -Wall -Wextra "$file" -o "${file%%.*}" && ./"${file%%.*}"
}

function CompileCPP() {
    local file="$1"
    g++ -std=c++14 -fno-elide-constructors -Wall -Wextra "$file" -o "${file%%.*}" && ./"${file%%.*}"
}

function Compile_C() {
    local file="$1"
    clang -Wall -Wextra "$file" -o "${file%%.*}" && ./"${file%%.*}"
}

function Compile_CPP() {
    local file="$1"
    clang++ -Wall -Wextra "$file" -o "${file%%.*}" && ./"${file%%.*}"
}

function yt-dlp_download() {
    local url="$@"
    yt-dlp -f "bestvideo[height<=1080]+bestaudio/audio[height<=1080]" "$url"
}

