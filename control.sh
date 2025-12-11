#!/usr/bin/env sh

# Setup everythin for every_shell_script

USAGE=$(cat << EOF
usage: $(basename $0) [-v,--verbose] [-b,--branch <branchname>] [--vim] [-h,--help] [start|stop|restart|reload|log]
  -h, --help                  Show this help message and exit
  -v, --verbose               Provide a verbose output
      --vim                   Enable vim motions plugin
  -b, --branch <branchname>   Check and switch to branch <branchname>.
                              If a branch switch is detected, container will be stopped first
  -a, --all                   Open all links, not only the first.
    commands:
      start                   Build and start container
      stop                    Stops container
      restart                 Restart container
      reload                  Lifereload changed containers
      log                     Show and follow logfiles
EOF
)

RUNNING=true

clean_up() {
  RUNNING=false
  log_info Bye!
}

# Default way to load every_shell_script

which every_shell_script.sh >/dev/null 2>&1 && . $(every_shell_script.sh) || {
  echo install https://github.com/hifigraz/every_shell_script.sh >&2
  exit 255
}

usage() {
  printf "%s\n" "${USAGE}"
}

fail() {
  exit_code=$1
  shift
  log_error $*
  clean_up
  exit ${exit_code}
}

# Variables here 

CMD=""
ARGS=""
VIM="no"
VERBOSE=0
WORKDIR=$(cd $(dirname $0); pwd)
cd ${WORKDIR}
BRANCH=$(git branch --show-current)
CHROMIUM_DIR=${TMP_USER}/container/
ALL=no
mkdir -p ${CHROMIUM_DIR}

# Main 

main() {
  while [ "$#" -ge 1 ]; do
    log_debug looking for $1
    case "$1" in
      -v | --verbose)
        LOG_LEVEL=1
        log_debug Debugging enable
        shift
        ;;
      -a | --all)
        log_debug got all switch
        ALL=yes
        shift
        ;; 
      -h | --help)
        log_debug got help switch
        usage
        exit 0
        ;;
      --vim)
        log_Debug got vim switch
        VIM="yes"
        shift
        ;;
      -b | --branch)
        log_debug got branch switch
        if [ -z "$2" ]; then
          fail 2 $1 needs a branch name given
        else
          BRANCH=$2
          shift
          shift
        fi
        ;;
      *)
        log_debug "Looking for $1"
        if [ -z "${CMD}" ]; then
          case "$1" in
            start)
              CMD=$1
              ;;
            stop)
              CMD=$1
              ;;
            restart)
              CMD=$1
              ;;
            reload)
              CMD=$1
              ;;
            log)
              CMD=$1
              ;;
            *)
              fail 1 unknown parameter $1
              ;;
          esac
          shift
        else
          ARGS="${ARGS} $1"
          shift
        fi
        ;;
    esac
  done

  log_debug CMD = ${CMD} ...
  if [ -z "${CMD}" ]; then
    CMD=start
  fi

  log_info COMMAND: ${CMD}
  log_debug BRANCH: ${BRANCH}
  log_debug WORKDIR: ${WORKDIR}

  case ${CMD} in
    start)
      switch_branch
      start_container
      start_browser
      ;;
    stop)
      stop_browser
      stop_container
      switch_branch
      ;;
    restart)
      stop_container
      switch_branch
      start_container
      ;;
    reload)
      switch_branch
      start_container
      ;;
    log)
      follow_logs
      ;;
    *)
      fail 20 unknwon command ${CMD}
      ;;
  esac
}


update_config() {
  log_debug Pulling config
  git pull --all
}

update_images() {
  log_debug Pulling images
  docker compose pull
}

stop_container() {
  log_debug shutdown 
  docker compose down
}

start_container() {
  log_debug building build and start 
  for EXTENSION_FILE in $(find . -name extensions.txt); do 
    if [ "${VIM}" = "yes" ]; then
      echo auiworks.amvim >> ${EXTENSION_FILE}
    fi
  done
  
  docker compose up --build -d
  log_debug is up, unpatching extension file
  
  for EXTENSION_FILE in $(find . -name extensions.txt); do 
    grep -v auiworks.amvim ${EXTENSION_FILE} > ${EXTENSION_FILE}.tmp 
    mv ${EXTENSION_FILE}.tmp ${EXTENSION_FILE}
  done
  log_debug start finished
}

switch_branch() {
  log_debug switching branch
  current_branch=$(git branch --show-current)
  if [ "${BRANCH}" != "${current_branch}" ]; then
    unlink workspace
    [ -e workspace_${BRANCH} ] || mkdir workspace_${BRANCH}
    ln -s workspace_${BRANCH} workspace
    stop_container
    git checkout ${BRANCH} || fail 10 Switching branch failed
  fi
}

follow_logs() {
  log_debug following log files
  docker compose logs --follow ${ARGS}
}

start_browser() {
  stop_browser
  cat url.txt | while IFS= read -r raw_url; do
    url=$(echo ${raw_url} | sed s/\ *#.*//)
    [ -z "${url}" ] && continue
    count=0
    log_info Try opening url: ${raw_url}
    while ( ! curl --retry 5 --retry-all-errors ${url} >/dev/null 2>&1 || curl ${url} 2>&1 | grep 404 > /dev/null 2>&1); do
      sleep 1
      echo -n . >&2
      let count=count+1
      if [ ${count} -gt 20 ] ; then
        fail 30 noread: ${raw_url} 
      fi
      if [ ! ${RUNNING} ]; then
        break
      fi
    done
    sleep 1
    chromium --user-data-dir=${CHROMIUM_DIR}/data --app=${url} >/dev/null 2>&1 &
    [ -e ${CHROMIUM_DIR}/pid ] || echo $! > ${CHROMIUM_DIR}/pid
    if [ "${ALL}" = "no" ]; then
      break
    fi
  done
}

stop_browser() {
  [ -e ${CHROMIUM_DIR}/pid ] && kill $(cat ${CHROMIUM_DIR}/pid)
  [ -e ${CHROMIUM_DIR}/pid ] && rm ${CHROMIUM_DIR}/pid
}

main $*
clean_up
exit 0

