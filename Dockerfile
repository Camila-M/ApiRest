FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS builder
WORKDIR /app

COPY ./src/Supermarket.API/Supermarket.API.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish ./src/Supermarket.API/Supermarket.API.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=builder /app/out .
RUN dotnet dev-certs https --trust
ENTRYPOINT ["dotnet", "Supermarket.API.dll"]