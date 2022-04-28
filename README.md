# bclohes
A script that block some clothes by permission

## How to use
### > In config file do

```lua
["mascara"] = {
--   ^ 
--   |- Clothing category
    [18] = { models = { "female", "male" } , perms = { "Dono", "admin.permissao" }}
--    ^         ^                              ^                             
--    |         |- Blocked models              | - Permissions that can be use
--    |- Clothes number
}
```

## Script required
### > vRP/vRPex - Framework
