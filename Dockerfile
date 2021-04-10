# `as builder [as `stage name`]`란
# 현재 FROM부터 다음 FROM까지 
# builder stage라는 것을 명시
# -----------------------
# builder stage란
# 빌드 파일 생성을 목적으로 함
# 생성된 파일과 폴더들은 `/usr/src/app/build`로 들어감
# --------- builder stage ---------
FROM node:alpine as builder

WORKDIR /usr/scr/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# ---------------------------------

FROM nginx
# 맵핑할 포트 정의
EXPOSE 80
# 다른 stage에 있는 파일을 복사할 땐
# 해당 stage의 이름을 명시
COPY --from=builder /usr/scr/app/build /usr/share/nginx/html