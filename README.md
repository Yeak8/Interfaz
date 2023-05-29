$git_commiter_date="2023-05-08 20:57:09" git commit - -date="2023-05-08 20:57:09"
git filter-branch --env-filter \
    'if [ "$GIT_COMMIT" == "6489982f81797b71534357fa5a442a2604c61eff" ]
         then
                  export GIT_AUTHOR_DATE="2016-03-20T05:57:12-03:00"
                  export GIT_COMMITTER_DATE="2016-03-20T05:57:12-03:00"
     fi'
