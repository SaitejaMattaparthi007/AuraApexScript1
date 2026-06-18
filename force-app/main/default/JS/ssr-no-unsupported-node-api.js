import { LightningElement } from 'lwc';
import fs from 'fs';
import { exec } from 'child_process';
import net from 'net';

export default class MyComponent extends LightningElement {
    connectedCallback() {
        const data = fs.readFileSync('/tmp/config.json', 'utf8');
        exec('ls -la', (err, stdout) => {
            console.log(stdout);
        });
        const server = net.createServer();
    }
}
