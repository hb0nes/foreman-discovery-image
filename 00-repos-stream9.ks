url --url https://mirror.stream.centos.org/9-stream/BaseOS/$basearch/os/
repo --name="epel-el9" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-9&arch=x86_64
repo --name="epel-next-el9" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-9&arch=x86_64
repo --name="AppStream" --baseurl=https://mirror.stream.centos.org/9-stream/AppStream/$basearch/os/
repo --name="foreman-el9" --baseurl=http://yum.theforeman.org/releases/nightly/el9/$basearch/
repo --name="foreman-plugins-el9" --baseurl=http://yum.theforeman.org/plugins/nightly/el9/$basearch/
