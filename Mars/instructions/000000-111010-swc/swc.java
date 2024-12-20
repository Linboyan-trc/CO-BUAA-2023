import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class swc extends BranchOperation implements AdditionalInstruction {

    private int mycal(int v1, int v2) {
        int bitsV2 = v2 & 0b11111;
        if((v2&0b1)==1){//奇数
            return ((v1<<bitsV2)|(v1>>>(32 - bitsV2)));
        }else{//偶数
            return ((v1>>>bitsV2)|(v1<<(32 - bitsV2)));
        }
    }
    

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {

        int[] operands = statement.getOperands();
        int v1 = RegisterFile.getValue(operands[1]);
        int v2 = RegisterFile.getValue(operands[2]);
        int v3 = mycal(v1,v2);
        RegisterFile.updateRegister(operands[0], v3);

    }

    @Override
    public String getExample() {
        return "swc $t1,$t2,$t3";
    }

    @Override
    public String getDescription() {
        return "swc";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.R_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "000000 sssss ttttt fffff 00000 111010";
    }
}
